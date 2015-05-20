package com.ogdencity.wmnsfconfidentialfunds.controller;

import com.ogdencity.wmnsfconfidentialfunds.model.User;
import com.ogdencity.wmnsfconfidentialfunds.repo.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by tyler on 5/16/15.
 */
@Controller
public class Report {

    @RequestMapping("/Reports")
    public String Report(){
        return "report";
    }


    @Autowired
    private UserRepo userRepo;

    public User GetUserByEmail(String email){
        List<User> users = userRepo.findByEmail(email);
        return (users.size() > 0) ? users.get(0) : null;
    }

    @RequestMapping("/test")
    public @ResponseBody Object test(){
        List<User> test = userRepo.findAll();
        return test;
    }
}
