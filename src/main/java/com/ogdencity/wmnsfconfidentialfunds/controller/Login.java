package com.ogdencity.wmnsfconfidentialfunds.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by tyler on 5/16/15.
 */
@Controller
public class Login {

    @RequestMapping("/")
    public String Login(){
        return "login";
    }
}
