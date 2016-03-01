package com.ogdencity.wmnsfconfidentialfunds.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Login {

    @RequestMapping("/")
    public String Login(){
        return "login";
    }
}
