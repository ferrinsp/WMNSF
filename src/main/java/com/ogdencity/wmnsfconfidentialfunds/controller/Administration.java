package com.ogdencity.wmnsfconfidentialfunds.controller;

import com.ogdencity.wmnsfconfidentialfunds.enums.NotificationTypes;
import com.ogdencity.wmnsfconfidentialfunds.model.FundType;
import com.ogdencity.wmnsfconfidentialfunds.model.Permission;
import com.ogdencity.wmnsfconfidentialfunds.model.User;
import com.ogdencity.wmnsfconfidentialfunds.repo.FundTypeRepo;
import com.ogdencity.wmnsfconfidentialfunds.repo.PermissionRepo;
import com.ogdencity.wmnsfconfidentialfunds.repo.UserRepo;

import org.apache.naming.java.javaURLContextFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;

import java.security.Principal;
import java.security.SecureRandom;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Properties;
import java.util.Random;
import java.util.Set;

@Controller
@RequestMapping("/Administration")
public class Administration {

    @Autowired
    private UserRepo userRepo;
    @Autowired
    private PermissionRepo permissionRepo;
    @Autowired
    PasswordEncoder encoder;
    @Autowired
    private FundTypeRepo fundTypeRepo;
    @PersistenceContext
    EntityManager em;

    @RequestMapping(method = RequestMethod.GET)
    public String Administration(ModelMap model , Principal principal){
        List<Sort.Order> order = new ArrayList<>();
        order.add(new Sort.Order(Sort.Direction.DESC, "enabled"));
        order.add(new Sort.Order(Sort.Direction.ASC, "firstName"));

        List<User> users = userRepo.findAll(new Sort(order));
        model.addAttribute("users", users);

        List<Permission> permissions = permissionRepo.findAll();
        model.addAttribute("permissions", permissions);
        
        List<Sort.Order> order2 = new ArrayList<>();
        order2.add(new Sort.Order(Sort.Direction.DESC, "effectiveStart"));
        
        List<FundType> fundTypes = fundTypeRepo.findAll(new Sort(order2));
        model.addAttribute("fundTypes", fundTypes);
        
        User operator = userRepo.findByEmail(principal.getName()).get(0);
        model.addAttribute("balance", operator.getBalance());

        return "administration";
    }

    @Transactional
    @RequestMapping("/NewUser")
    public ModelAndView NewUser(HttpServletRequest request, RedirectAttributes redirectAttributes){
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String permissions[] = request.getParameterValues("permission");
        String email = request.getParameter("email");
        
        User user = new User();
        
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setEnabled(true);

        List<Permission> givenPermissions = new ArrayList<>();
        for(String permission : permissions)
        {
            givenPermissions.add(permissionRepo.findById(Long.parseLong(permission)));
        }
        user.setPermissions(givenPermissions);

        resetPassword(user);
        em.persist(user);
        redirectAttributes.addFlashAttribute(NotificationTypes.SUCCESS.toString(), "User " + user.getFullName() + " has been successfully added.");
        return new ModelAndView("redirect:/Administration");
    }
    
    @Transactional
    @RequestMapping("/newPassword")
    public ModelAndView NewPassword(HttpServletRequest request, RedirectAttributes redirectAttributes){
    	String email = request.getParameter("id");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String verifyNewPassword = request.getParameter("verifyNewPassword");
        
        
        User user = userRepo.findByEmail(email).get(0);
        System.out.println(user.getFirstName());
        System.out.println(user.getPassword());
        System.out.println(encoder.encode(oldPassword));
        System.out.println(newPassword);
        System.out.println(verifyNewPassword);
        if(newPassword.equals(verifyNewPassword))
        {
        	String encodedPassword = encoder.encode(newPassword);
            user.setPassword(encodedPassword);
        }
        else
        	System.out.println("failed");
        
        
        user.setEnabled(true);

        em.persist(user);
        redirectAttributes.addFlashAttribute(NotificationTypes.SUCCESS.toString(), "Your password has been reset successfully.");
        
        return new ModelAndView("redirect:/Administration");
    }
    
    public String resetPassword(User user) {
    	
    		String email = user.getEmail();
    		final String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    		SecureRandom rnd = new SecureRandom();

    		StringBuilder sb = new StringBuilder(9);
    		for( int i = 0; i < 9; i++ ) 
    		   sb.append( AB.charAt( rnd.nextInt(AB.length()) ) );
    		
    		String userPassword = sb.toString();

    		final String username = "weber.narcotics.strike.force@gmail.com";
    		final String password = "wmnstrike4ce";
    		
    		Properties props = new Properties();
    		props.put("mail.smtp.auth", "true");
    		props.put("mail.smtp.starttls.enable", "true");
    		props.put("mail.smtp.host", "smtp.gmail.com");
    		props.put("mail.smtp.port", "587");

    		Session session = Session.getInstance(props,
    		  new javax.mail.Authenticator() {
    			protected PasswordAuthentication getPasswordAuthentication() {
    				return new PasswordAuthentication(username, password);
    			}
    		  });

    		try {
    			Message message = new MimeMessage(session);
    			message.setFrom(new InternetAddress("weber.narcotics.strike.force@gmail.com"));
    			message.setRecipients(Message.RecipientType.TO,
    				InternetAddress.parse(email));
    			message.setSubject("Password Reset Request");
    			message.setText("Your Password has been reset to " + userPassword);

    			Transport.send(message);

    		} catch (MessagingException e) {
    			throw new RuntimeException(e);
    		}
    		String encodedPassword = encoder.encode(userPassword);
            user.setPassword(encodedPassword);
    		return userPassword;
    	}
    
    @Transactional
    @RequestMapping("/ResetPassword")
    public @ResponseBody void resetPassword(String id) {
    	    	
    	long userId = Long.parseLong(id);
    	System.out.println(id);
        User user = userRepo.findById(userId);
        resetPassword(user);
    }
    
    @Transactional
    @RequestMapping("/NewFundType")//Built but not fully working
    public ModelAndView NewFundType(HttpServletRequest request, RedirectAttributes redirectAttributes){
    	
    	String description = request.getParameter("description");
    	DateFormat format = new SimpleDateFormat("MM/dd/yyyy", Locale.ENGLISH);
    	String effectiveStart = request.getParameter("effectiveStart");
    	String effectiveEnd = request.getParameter("effectiveEnd");
    	//String unallocatedFunds= request.getParameter("fundTotal");
    	//TODO: Store the fund amount into database
    	
    	FundType fundType = new FundType();
    	fundType.setDescription(description);
    	try {
            fundType.setEffectiveStart(format.parse(effectiveStart));
        } catch (ParseException e) {
            e.printStackTrace();
        }
    	
    	try {
            fundType.setEffectiveEnd(format.parse(effectiveEnd));
        } catch (ParseException a) {
            a.printStackTrace();
        }
		em.persist(fundType);
		redirectAttributes.addFlashAttribute(NotificationTypes.SUCCESS.toString(), "Fund Type " + fundType.getDescription() + " has been successfully added.");
		return new ModelAndView("redirect:/Administration");
    }

    @Transactional
    @RequestMapping("/StatusUpdate")
    public ModelAndView StatusUpdate(HttpServletRequest request, RedirectAttributes redirectAttributes){

        long id = Long.parseLong(request.getParameter("id"));
        String status = request.getParameter("status");

        boolean enable = (status.equals("enable")) ? true : false;
        User user = userRepo.findById(id);
        user.setEnabled(enable);

        em.persist(user);

        return new ModelAndView("redirect:/Administration");
    }

    @Transactional
    @RequestMapping("/EditUser")
    public ModelAndView EditUser(HttpServletRequest request, RedirectAttributes redirectAttributes){
        long id = Long.parseLong(request.getParameter("id"));
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String permissions[] = request.getParameterValues("permission");

        User user = userRepo.findById(id);
        user.setFirstName(firstName);
        user.setLastName(lastName);

        List<Permission> givenPermissions = new ArrayList<>();
        if(permissions != null)
            for(String permission : permissions)
            {
                givenPermissions.add(permissionRepo.findById(Long.parseLong(permission)));
            }
        user.setPermissions(givenPermissions);
        return new ModelAndView("redirect:/Administration");
    }
    
    @Transactional
    @RequestMapping("/EditFundType")
    public ModelAndView EditFundType(HttpServletRequest request, RedirectAttributes redirectAttributes){
    	long id = Long.parseLong(request.getParameter("id"));
    	String description = request.getParameter("description");
    	DateFormat format = new SimpleDateFormat("MM/dd/yyyy", Locale.ENGLISH);
    	String effectiveStart = request.getParameter("effectiveStart");
    	String effectiveEnd = request.getParameter("effectiveEnd");
    	//String unallocatedFunds= request.getParameter("fundTotal");
    	//TODO: Get the fund amount from database
    	
    	FundType fundType = fundTypeRepo.findById(id);
    	fundType.setDescription(description);
    	
    	try {
            fundType.setEffectiveStart(format.parse(effectiveStart));
        } catch (ParseException e) {
            e.printStackTrace();
        }
    	
    	try {
            fundType.setEffectiveEnd(format.parse(effectiveEnd));
        } catch (ParseException a) {
            a.printStackTrace();
        }
		em.persist(fundType);
		redirectAttributes.addFlashAttribute(NotificationTypes.SUCCESS.toString(), "Fund Type " + fundType.getDescription() + " has been successfully added.");
		return new ModelAndView("redirect:/Administration");   	
    }
    @Transactional
    @RequestMapping("/StatusUser")
    public @ResponseBody User StatusUser(String id) {
        long userId = Long.parseLong(id);
        User user = userRepo.findById(userId);
        user.toggleStatus();
        em.persist(user);
        return  user;
    }

    @RequestMapping("/GetUser")
    public @ResponseBody User GetUser(String id) {
        long userId = Long.parseLong(id);
        User user = userRepo.findById(userId);
        return user;
    }
    
    @RequestMapping("/GetFundType")
    public @ResponseBody FundType GetFundType(String id) {
    	long fundTypeId = Long.parseLong(id);
    	FundType fundType = fundTypeRepo.findById(fundTypeId);
    	return fundType;
    }
}
