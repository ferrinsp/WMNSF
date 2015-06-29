package com.ogdencity.wmnsfconfidentialfunds.controller;

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
import org.springframework.web.servlet.ModelAndView;

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
    public ModelAndView NewUser(HttpServletRequest request){
        String firstName = request.getParameter("firstName").trim();
        String lastName = request.getParameter("lastName").trim();
        String permissions[] = request.getParameterValues("permission");
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();

        User user = new User();
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);

        password = encoder.encode(password);
        user.setPassword(password);

        List<Permission> givenPermissions = new ArrayList<>();
        for(String permission : permissions)
        {
            givenPermissions.addAll(permissionRepo.findById(Long.parseLong(permission)));
        }
        user.setPermissions(givenPermissions);

        em.persist(user);

        return new ModelAndView("redirect:/Administration");
    }

    @Transactional
    @RequestMapping("/StatusUpdate")
    public ModelAndView StatusUpdate(HttpServletRequest request){

        String email = request.getParameter("email");
        String status = request.getParameter("status");

        boolean enable = (status.equals("enable")) ? true : false;
        User user = userRepo.findByEmail(email).get(0);
        user.setEnabled(enable);

        em.persist(user);

        return new ModelAndView("redirect:/Administration");
    }

    @Transactional
    @RequestMapping("/EditUser")
    public ModelAndView EditUser(HttpServletRequest request){
        String firstName = request.getParameter("firstName").trim();
        String lastName = request.getParameter("lastName").trim();
        String permission = request.getParameter("permission");
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();

        User user = userRepo.findByEmail(email).get(0);
        user.setFirstName(firstName);
        user.setLastName(lastName);
        //user.setEmail(email);

        password = encoder.encode(password);
        user.setPassword(password);
        user.setPermissions(permissionRepo.findById(Long.parseLong(permission)));

        em.persist(user);

        return new ModelAndView("redirect:/Administration");
    }
}
