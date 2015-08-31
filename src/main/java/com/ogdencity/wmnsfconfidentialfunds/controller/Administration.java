package com.ogdencity.wmnsfconfidentialfunds.controller;

import com.ogdencity.wmnsfconfidentialfunds.enums.NotificationTypes;
import com.ogdencity.wmnsfconfidentialfunds.model.Permission;
import com.ogdencity.wmnsfconfidentialfunds.model.User;
import com.ogdencity.wmnsfconfidentialfunds.repo.PermissionRepo;
import com.ogdencity.wmnsfconfidentialfunds.repo.UserRepo;
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
import java.util.ArrayList;
import java.util.List;

/**
 * Created by tyler on 5/16/15.
 */
@Controller
@RequestMapping("/Administration")
public class Administration {

    @Autowired
    private UserRepo userRepo;
    @Autowired
    private PermissionRepo permissionRepo;
    @Autowired
    PasswordEncoder encoder;
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

        return "administration";
    }

    @Transactional
    @RequestMapping("/NewUser")
    public ModelAndView NewUser(HttpServletRequest request, RedirectAttributes redirectAttributes){
        String firstName = request.getParameter("firstName").trim();
        String lastName = request.getParameter("lastName").trim();
        String permissions[] = request.getParameterValues("permission");
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();

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
        String firstName = request.getParameter("firstName").trim();
        String lastName = request.getParameter("lastName").trim();
        String permissions[] = request.getParameterValues("permission");
        String password = request.getParameter("password").trim();

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
}
