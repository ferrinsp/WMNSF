package com.ogdencity.wmnsfconfidentialfunds;

import com.ogdencity.wmnsfconfidentialfunds.model.User;
import com.ogdencity.wmnsfconfidentialfunds.repo.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ViewResolver;

@SpringBootApplication
public class WmnsfConfidentialFundsApplication {

    public static void main(String[] args) {
        SpringApplication.run(WmnsfConfidentialFundsApplication.class, args);
    }
}