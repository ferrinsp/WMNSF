package com.ogdencity.wmnsfconfidentialfunds.controller;

import com.ogdencity.wmnsfconfidentialfunds.enums.NotificationTypes;
import com.ogdencity.wmnsfconfidentialfunds.model.FundType;
import com.ogdencity.wmnsfconfidentialfunds.model.TransferTransaction;
import com.ogdencity.wmnsfconfidentialfunds.model.User;
import com.ogdencity.wmnsfconfidentialfunds.repo.FundTypeRepo;
import com.ogdencity.wmnsfconfidentialfunds.repo.TransferTransactionRepo;
import com.ogdencity.wmnsfconfidentialfunds.repo.UserRepo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.http.HttpServletRequest;
import java.security.Principal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

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
    @Autowired
    PasswordEncoder encoder;

    @RequestMapping(method = RequestMethod.GET)
    public String Transaction(ModelMap model, Principal principal){
    	if(userRepo.findByEmail(principal.getName()).isEmpty()) return "transaction"; // SAFETY
    	
        User operator = userRepo.findByEmail(principal.getName()).get(0);
        List<User> allEnabledUsers = userRepo.findByEnabledTrue();
        Date now = new Date();
        List<FundType> allActiveFundTypes = fundTypeRepo.findByEffectiveStartBeforeAndEffectiveEndAfter(now, now);
        List<TransferTransaction> transferTransactions = transferTransactionRepo.getAllTransactions();

        model.addAttribute("allEnabledUsers", allEnabledUsers);
        model.addAttribute("allActiveFundTypes", allActiveFundTypes);
        model.addAttribute("transferTransactions", transferTransactions);
        return "transaction";
    }

    @Transactional
    @RequestMapping("/NewTransferTransaction")
    public ModelAndView NewTransferTransaction(HttpServletRequest request, Principal principal, RedirectAttributes redirectAttributes) {
        String operatorEmail = principal.getName();

        TransferTransaction transferTransaction = new TransferTransaction();
        transferTransaction.setTransactionType("Transfer");
        String description = request.getParameter("description");
        String checkNumber = request.getParameter("checkNumber");
        String caseNumber = request.getParameter("caseNumber");
        String ciNumber = request.getParameter("ciNumber");
        transferTransaction.setDescription(description);
        DateFormat format = new SimpleDateFormat("MM/dd/yyyy", Locale.ENGLISH);
        String stringDate = request.getParameter("date");
        try {
            transferTransaction.setDate(format.parse(stringDate));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        String debitOfficerId = request.getParameter("debitOfficer");
        String creditOfficerId = request.getParameter("creditOfficer");

        User debitOfficer = userRepo.findOne(Long.parseLong(debitOfficerId));
        debitOfficer.setBalance(debitOfficer.getBalance() - Double.parseDouble(request.getParameter("amount")));
        User creditOfficer = userRepo.findOne(Long.parseLong(creditOfficerId));
        creditOfficer.setBalance(creditOfficer.getBalance() + Double.parseDouble(request.getParameter("amount")));

        transferTransaction.setDebitUser(debitOfficer);
        transferTransaction.setCreditUser(creditOfficer);
        if(userRepo.findByEmail(operatorEmail).isEmpty()) return new ModelAndView("redirect:/Transaction"); // SAFETY
        transferTransaction.setOperatorUser(userRepo.findByEmail(operatorEmail).get(0));
        transferTransaction.setAmount(Double.parseDouble(request.getParameter("amount")));
        transferTransaction.setFundType(fundTypeRepo.findOne(Long.parseLong(request.getParameter("fundType"))));
        transferTransaction.setCheckNumber(checkNumber);
        transferTransaction.setCaseNumber(caseNumber);
        transferTransaction.setCiNumber(ciNumber);
        
        String debitPassword = request.getParameter("debitPassword");
        String creditPassword = request.getParameter("creditPassword");

        if (encoder.matches(debitPassword, debitOfficer.getPassword()) && encoder.matches(creditPassword, creditOfficer.getPassword())) {
        	try {
        		em.persist(transferTransaction);
        		em.merge(debitOfficer);
        		em.merge(creditOfficer);
                redirectAttributes.addFlashAttribute(NotificationTypes.SUCCESS.toString(), "Transfer successfully saved.");
			} catch (Exception e) {
				System.out.println("Error committing to database");
				e.printStackTrace();
			}
        }
        else {
            redirectAttributes.addFlashAttribute("failedTransferTransaction", transferTransaction);
            redirectAttributes.addFlashAttribute(NotificationTypes.ERROR.toString(), "Passwords do not match.");
        }

        return new ModelAndView("redirect:/Transaction");
    }
    
    @Transactional
    @RequestMapping("/NewDepositTransaction")
    public ModelAndView NewDepositTransaction(HttpServletRequest request, Principal principal, RedirectAttributes redirectAttributes) {
        String operatorEmail = principal.getName();

        TransferTransaction depositTransaction = new TransferTransaction();
        depositTransaction.setTransactionType("Deposit");
        String description = request.getParameter("description");
        String checkNumber = request.getParameter("checkNumber");
        String caseNumber = request.getParameter("caseNumber");
        String ciNumber = request.getParameter("ciNumber");
        depositTransaction.setDescription(description);
        DateFormat format = new SimpleDateFormat("MM/dd/yyyy", Locale.ENGLISH);
        String stringDate = request.getParameter("date");
        try {
        	depositTransaction.setDate(format.parse(stringDate));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        String creditOfficerId = request.getParameter("creditOfficer");

        User creditOfficer = userRepo.findOne(Long.parseLong(creditOfficerId));
        creditOfficer.setBalance(creditOfficer.getBalance() + Double.parseDouble(request.getParameter("amount")));
        
        depositTransaction.setDebitUser(null);
        depositTransaction.setCreditUser(creditOfficer);
        if(userRepo.findByEmail(operatorEmail).isEmpty()) return new ModelAndView("redirect:/Transaction"); // SAFETY
        depositTransaction.setOperatorUser(userRepo.findByEmail(operatorEmail).get(0));
        depositTransaction.setAmount(Double.parseDouble(request.getParameter("amount")));
        depositTransaction.setFundType(fundTypeRepo.findOne(Long.parseLong(request.getParameter("fundType"))));
        depositTransaction.setCheckNumber(checkNumber);
        depositTransaction.setCaseNumber(caseNumber);
        depositTransaction.setCiNumber(ciNumber);
        
        String creditPassword = request.getParameter("creditPassword");

        if (encoder.matches(creditPassword, creditOfficer.getPassword())) {
        	try {
        		em.persist(depositTransaction);
        		em.merge(creditOfficer);
                redirectAttributes.addFlashAttribute(NotificationTypes.SUCCESS.toString(), "Deposit successfully saved.");
			} catch (Exception e) {
				System.out.println("Error committing to database");
				e.printStackTrace();
			}
        }
        else {
            redirectAttributes.addFlashAttribute("failedTransferTransaction", depositTransaction);
            redirectAttributes.addFlashAttribute(NotificationTypes.ERROR.toString(), "Passwords do not match.");
        }
        return new ModelAndView("redirect:/Transaction");
    }

    @Transactional
    @RequestMapping("/NewExpenditure")
    public ModelAndView NewExpenditure(HttpServletRequest request, Principal principal, RedirectAttributes redirectAttributes) {
        String operatorEmail = principal.getName();

        TransferTransaction expenditureTransaction = new TransferTransaction();
        expenditureTransaction.setTransactionType("Expenditure");
        String description = request.getParameter("description");
        String checkNumber = request.getParameter("checkNumber");
        String caseNumber = request.getParameter("caseNumber");
        String ciNumber = request.getParameter("ciNumber");
        expenditureTransaction.setDescription(description);
        DateFormat format = new SimpleDateFormat("MM/dd/yyyy", Locale.ENGLISH);
        String stringDate = request.getParameter("date");
        try {
            expenditureTransaction.setDate(format.parse(stringDate));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        String creditOfficerId = request.getParameter("creditOfficer");

        User creditOfficer = userRepo.findOne(Long.parseLong(creditOfficerId));
        creditOfficer.setBalance(creditOfficer.getBalance() + Double.parseDouble(request.getParameter("amount")));
        
        expenditureTransaction.setDebitUser(null);
        expenditureTransaction.setCreditUser(creditOfficer);
        if(userRepo.findByEmail(operatorEmail).isEmpty()) return new ModelAndView("redirect:/Transaction"); // SAFETY
        expenditureTransaction.setOperatorUser(userRepo.findByEmail(operatorEmail).get(0));
        expenditureTransaction.setAmount(Double.parseDouble(request.getParameter("amount")));
        expenditureTransaction.setFundType(fundTypeRepo.findOne(Long.parseLong(request.getParameter("fundType"))));
        expenditureTransaction.setCheckNumber(checkNumber);
        expenditureTransaction.setCaseNumber(caseNumber);
        expenditureTransaction.setCiNumber(ciNumber);
        
        String creditPassword = request.getParameter("creditPassword");

        if (encoder.matches(creditPassword, creditOfficer.getPassword())) {
        	try {
        		em.persist(expenditureTransaction);
        		em.merge(creditOfficer);
                redirectAttributes.addFlashAttribute(NotificationTypes.SUCCESS.toString(), "Expenditure successfully saved.");
			} catch (Exception e) {
				System.out.println("Error committing to database");
				e.printStackTrace();
			}
        }
        else {
            redirectAttributes.addFlashAttribute("failedExpenditureTransaction", expenditureTransaction);
            redirectAttributes.addFlashAttribute(NotificationTypes.ERROR.toString(), "Passwords do not match.");
        }
        return new ModelAndView("redirect:/Transaction");
    }
}
