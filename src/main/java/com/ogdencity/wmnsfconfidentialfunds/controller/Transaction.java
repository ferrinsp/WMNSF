package com.ogdencity.wmnsfconfidentialfunds.controller;

import com.ogdencity.wmnsfconfidentialfunds.model.TransferTransaction;
import com.ogdencity.wmnsfconfidentialfunds.repo.TransferTransactionRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

/**
 * Created by tyler on 5/16/15.
 */
@Controller
public class Transaction {

    @Autowired
    private TransferTransactionRepo transferTransactionRepo;
    @PersistenceContext
    EntityManager em;


    @RequestMapping("/Transactions")
    public String Transaction(ModelMap model){
        //List<TransferTransaction> transferTransactions = transferTransactionRepo.findAll();

        //model.addAttribute("transferTransactions", transferTransactions);
        return "transfer";
    }
}
