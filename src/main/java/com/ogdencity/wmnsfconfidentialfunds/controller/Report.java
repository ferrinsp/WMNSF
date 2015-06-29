package com.ogdencity.wmnsfconfidentialfunds.controller;

import com.ogdencity.wmnsfconfidentialfunds.model.TransferTransaction;
import com.ogdencity.wmnsfconfidentialfunds.model.User;
import com.ogdencity.wmnsfconfidentialfunds.repo.TransferTransactionRepo;
import com.ogdencity.wmnsfconfidentialfunds.repo.UserRepo;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by tyler on 5/16/15.
 */
@Controller
@RequestMapping("/Reports")
public class Report {
    @Autowired
    private UserRepo userRepo;
    @Autowired
    private TransferTransactionRepo transferTransactionRepo;

    @RequestMapping(method = RequestMethod.GET)
    public String Report(ModelMap model, Principal principal){
        User operator = userRepo.findByEmail(principal.getName()).get(0);
        List<User> allEnabledUsers = new ArrayList<>();

        if(operator.isAdmin()) {
             allEnabledUsers.addAll(userRepo.findByEnabledTrue());
        }
        else{
            allEnabledUsers.add(operator);
        }

        model.addAttribute("users", allEnabledUsers);
        return "report";
    }

    @RequestMapping("/Search")
    public ModelAndView NewTransferTransaction(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        long userId = Long.parseLong(request.getParameter("users"));
        List<TransferTransaction> transferTransactions = transferTransactionRepo.findByCreditUserIdOrDebitUserId(userId, userId);
        redirectAttributes.addFlashAttribute("transactions", transferTransactions);
        return new ModelAndView("redirect:/Reports");
    }
}
