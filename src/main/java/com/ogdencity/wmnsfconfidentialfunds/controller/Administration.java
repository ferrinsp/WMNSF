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

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.http.HttpServletRequest;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

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
    public String Administration(ModelMap model){
        List<Sort.Order> order = new ArrayList<>();
        order.add(new Sort.Order(Sort.Direction.DESC, "enabled"));
        order.add(new Sort.Order(Sort.Direction.ASC, "firstName"));

        List<User> users = userRepo.findAll(new Sort(order));
        model.addAttribute("users", users);

        List<Permission> permissions = permissionRepo.findAll();
        model.addAttribute("permissions", permissions);
        
        List<Sort.Order> order2 = new ArrayList<>();
        order2.add(new Sort.Order(Sort.Direction.DESC, "effectiveStart"));//added by Dylan 11/15/2015
        
        List<FundType> fundTypes = fundTypeRepo.findAll(new Sort(order2));//added by Dylan 11/15/2015
        model.addAttribute("fundTypes", fundTypes);

        return "administration";
    }

    @Transactional
    @RequestMapping("/NewUser")
    public ModelAndView NewUser(HttpServletRequest request, RedirectAttributes redirectAttributes){
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String permissions[] = request.getParameterValues("permission");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = new User();
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setEnabled(true);

        password = encoder.encode(password);
        user.setPassword(password);

        List<Permission> givenPermissions = new ArrayList<>();
        for(String permission : permissions)
        {
            givenPermissions.add(permissionRepo.findById(Long.parseLong(permission)));
        }
        user.setPermissions(givenPermissions);

        String errorMessage = ValidateUser(user, true);
        if(errorMessage.equals("")) {
            em.persist(user);
            redirectAttributes.addFlashAttribute(NotificationTypes.SUCCESS.toString(), "User " + user.getFullName() + " has been successfully added.");
        }
        else {
            redirectAttributes.addFlashAttribute(NotificationTypes.ERROR.toString(), errorMessage);
            redirectAttributes.addFlashAttribute("failedUser", user);
        }
        return new ModelAndView("redirect:/Administration");
    }
    
    @Transactional
    @RequestMapping("/NewFundType")//Built but not fully working
    public ModelAndView NewFundType(HttpServletRequest request, RedirectAttributes redirectAttributes){
    	
    	String description = request.getParameter("description");
    	DateFormat format = new SimpleDateFormat("MM/dd/yyyy", Locale.ENGLISH); //hours minutes and second included on database
    	String effectiveStart = request.getParameter("effectiveStart");
    	
    	String effectiveEnd = request.getParameter("effectiveEnd");
    	
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
    	
    	String errorMessage = ValidateFundType(fundType, true);
    	if(errorMessage.equals("")) {
    		em.persist(fundType);
    		redirectAttributes.addFlashAttribute(NotificationTypes.SUCCESS.toString(), "Fund Type " + fundType.getDescription() + " has been successfully added.");
    	}else {
    		redirectAttributes.addFlashAttribute(NotificationTypes.ERROR.toString(), errorMessage);
    		redirectAttributes.addFlashAttribute("failedFundType", fundType);
    	}	
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
        String password = request.getParameter("password");

        User user = userRepo.findById(id);
        user.setFirstName(firstName);
        user.setLastName(lastName);

        user.setPassword(password);

        List<Permission> givenPermissions = new ArrayList<>();
        if(permissions != null)
            for(String permission : permissions)
            {
                givenPermissions.add(permissionRepo.findById(Long.parseLong(permission)));
            }
        user.setPermissions(givenPermissions);

        String errorMessage = ValidateUser(user, false);
        if(errorMessage.equals("")) {
            password = encoder.encode(password);
            user.setPassword(password);
            em.persist(user);
            redirectAttributes.addFlashAttribute(NotificationTypes.SUCCESS.toString(), "User " + user.getFullName() + " has been successfully modified.");
        }
        else {
            redirectAttributes.addFlashAttribute(NotificationTypes.ERROR.toString(), errorMessage);
            redirectAttributes.addFlashAttribute("failedUser", user);
        }
        return new ModelAndView("redirect:/Administration");
    }
    
    @Transactional
    @RequestMapping("/EditFundType")//NEED TO TEST
    public ModelAndView EditFundType(HttpServletRequest request, RedirectAttributes redirectAttributes){
    	long id = Long.parseLong(request.getParameter("id"));
    	String description = request.getParameter("description");
    	DateFormat format = new SimpleDateFormat("MM/dd/yyyy", Locale.ENGLISH); //hours minutes seconds removed from database.
    	String effectiveStart = request.getParameter("effectiveStart");
    	String effectiveEnd = request.getParameter("effectiveEnd");
    	
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
    	
    	String errorMessage = ValidateFundType(fundType, true);
    	if(errorMessage.equals("")) {
    		em.persist(fundType);
    		redirectAttributes.addFlashAttribute(NotificationTypes.SUCCESS.toString(), "Fund Type " + fundType.getDescription() + " has been successfully added.");
    	}else {
    		redirectAttributes.addFlashAttribute(NotificationTypes.ERROR.toString(), errorMessage);
    		redirectAttributes.addFlashAttribute("failedFundType", fundType);
    	}
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
    
    @RequestMapping("/GetFundType")//NEED TO FIX DATE FORMATTING, currently set to be blank as ajax call creates a non date output
    public @ResponseBody FundType GetFundType(String id) {
    	long fundTypeId = Long.parseLong(id);
    	
    	FundType fundType = fundTypeRepo.findById(fundTypeId);
    	
    	//Date effectiveStart = fundType.getEffectiveStart();
    	//Date effectiveEnd = fundType.getEffectiveEnd();
    	
    	//DateFormat date = new SimpleDateFormat("MM/dd/yyyy");
    	
    	//fundType.setEffectiveStart(date.format(effectiveStart));
 
    	return fundType;
    }
    
    private String ValidateUser(User user, boolean newUser){

        if(user.getFirstName().length() == 0){
            return  "User must have a first name.";
        }
        if(user.getLastName().length() == 0){
            return  "User must have a last name.";
        }
        if((newUser && user.getPassword().length() <= 8) || (!newUser && user.getPassword().length() != 0 && user.getPassword().length() <= 8)){
            return "Password must be at least 8 characters long.";
        }
        return "";
    }
    
    private String ValidateFundType(FundType fundType, boolean newFundType)
    {
    	if(fundType.getDescription().length() == 0){
    		return "Fund Type must have a description.";
    	}
    	return "";
    }
}
