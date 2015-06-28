package com.ogdencity.wmnsfconfidentialfunds.controller;

import com.ogdencity.wmnsfconfidentialfunds.model.FundType;
import com.ogdencity.wmnsfconfidentialfunds.model.TransferTransaction;
import com.ogdencity.wmnsfconfidentialfunds.model.User;
import com.ogdencity.wmnsfconfidentialfunds.repo.FundTypeRepo;
import com.ogdencity.wmnsfconfidentialfunds.repo.TransferTransactionRepo;
import com.ogdencity.wmnsfconfidentialfunds.repo.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.http.HttpServletRequest;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by tyler on 5/16/15.
 */
@Controller
@RequestMapping("/Transaction")
public class Transaction {

    @Autowired
    private TransferTransactionRepo transferTransactionRepo;
    @Autowired
    private UserRepo userRepo;
    @Autowired
    private FundTypeRepo fundTypeRepo;
    @PersistenceContext
    EntityManager em;

    @RequestMapping(method = RequestMethod.GET)
    public String Transaction(ModelMap model){
        List<User> allEnabledUsers = userRepo.findByEnabledTrue();
        Date now = new Date();
        List<FundType> allActiveFundTypes = fundTypeRepo.findByEffectiveStartBeforeAndEffectiveEndAfter(now, now);

        List<TransferTransaction> transferTransactions = transferTransactionRepo.findAll();

        model.addAttribute("allEnabledUsers", allEnabledUsers);
        model.addAttribute("allActiveFundTypes", allActiveFundTypes);
        model.addAttribute("transferTransactions", transferTransactions);
        return "transaction";
    }

    @Transactional
    @RequestMapping("/NewTransferTransaction")
    public ModelAndView NewTransferTransaction(HttpServletRequest request){
        TransferTransaction transferTransaction = new TransferTransaction();
        String description = request.getParameter("description").trim();
        transferTransaction.setDescription(description);
        DateFormat format = new SimpleDateFormat("MMMM d, yyyy", Locale.ENGLISH);
        String stringDate = request.getParameter("date").trim();
        try {
            transferTransaction.setDate(format.parse(stringDate));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        transferTransaction.setDebitUser(userRepo.findOne(Long.parseLong(request.getParameter("debitOfficer").trim())));
        transferTransaction.setDebitUser(userRepo.findOne(Long.parseLong(request.getParameter("creditOfficer").trim())));
        transferTransaction.setAmount(Double.parseDouble(request.getParameter("amount").trim()));
        transferTransaction.setFundType(fundTypeRepo.findOne(Long.parseLong(request.getParameter("fundType").trim())));

        em.persist(transferTransaction);

        return new ModelAndView("redirect:/Transactions");
    }
}
