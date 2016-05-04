package com.ogdencity.wmnsfconfidentialfunds.controller;

import com.ogdencity.wmnsfconfidentialfunds.model.Search;
import com.ogdencity.wmnsfconfidentialfunds.enums.TransactionType;
import com.ogdencity.wmnsfconfidentialfunds.model.FundType;
import com.ogdencity.wmnsfconfidentialfunds.model.TransferTransaction;
import com.ogdencity.wmnsfconfidentialfunds.model.User;
import com.ogdencity.wmnsfconfidentialfunds.repo.FundTypeRepo;
import com.ogdencity.wmnsfconfidentialfunds.repo.TransferTransactionRepo;
import com.ogdencity.wmnsfconfidentialfunds.repo.UserRepo;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;

import java.security.Principal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

@Controller
@RequestMapping("/Reports")
public class Report {
    @Autowired
    private UserRepo userRepo;
    @Autowired
    private TransferTransactionRepo transferTransactionRepo;
    @Autowired
    private FundTypeRepo fundTypeRepo;

    @RequestMapping(method = RequestMethod.GET)
    public String Report(ModelMap model, Principal principal){
    	if(userRepo.findByEmail(principal.getName()).isEmpty()) return "report"; // SAFETY
        User operator = userRepo.findByEmail(principal.getName()).get(0);
        List<User> allEnabledUsers = new ArrayList<>();
        
        List<TransferTransaction> transferTransactions = transferTransactionRepo.findAll();
        
        if(!operator.isAdmin()){
	        for(Iterator<TransferTransaction> iterator = transferTransactions.iterator(); iterator.hasNext();){
	        	TransferTransaction tt = iterator.next();
	        	if(!tt.ownedBy(operator)){
	        		iterator.remove();
	        	}
	        }	
        }

        Date now = new Date();
        List<FundType> allFundTypes = fundTypeRepo.findAll();

        if(operator.isAdmin()){
             allEnabledUsers.addAll(userRepo.findByEnabledTrue());
        }
        else{
            allEnabledUsers.add(operator);
        }
        
        model.addAttribute("transactionTypes", TransactionType.values());
        model.addAttribute("users", allEnabledUsers);
        model.addAttribute("transactions", transferTransactions);
        model.addAttribute("fundTypes", allFundTypes);
        
        return "report";
    }

    @RequestMapping("/Search")
    public ModelAndView NewTransferTransaction(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        long userId = Long.parseLong(request.getParameter("users"));
        List<TransferTransaction> transferTransactions = new ArrayList<>();
        User user = userRepo.findById(userId);
        String stringEnd = request.getParameter("endDate");
        String stringStart = request.getParameter("startDate");

        Search search = new Search();

        search.setCredit(request.getParameter("cbCredit").equals("true"));
        search.setDebit(request.getParameter("cbDebit").equals("true"));
        search.setOperator(request.getParameter("cbOperator").equals("true"));

        Date startDate;
        Date endDate;
        DateFormat format = new SimpleDateFormat("MM/dd/yyyy", Locale.ENGLISH);

        try {
            startDate = format.parse(stringStart);
            endDate = format.parse(stringEnd);

            if(search.isCredit())
                transferTransactions.addAll(transferTransactionRepo.getCreditUserBetween(startDate, endDate, user));
            if(search.isDebit())
                transferTransactions.addAll(transferTransactionRepo.getDebitUserBetween(startDate,endDate,user));
            if(search.isOperator())
                transferTransactions.addAll(transferTransactionRepo.getOperatorUserBetween(startDate,endDate,user));

            transferTransactions.sort(TransferTransaction.TransferTransactionComparator);

            search.setEndDate(endDate);
            search.setStartDate(startDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        search.setTransactionType(TransactionType.EXPENDITURE);
        search.setUserId(userId);

        redirectAttributes.addFlashAttribute("search", search);
        redirectAttributes.addFlashAttribute("transactions", transferTransactions);
        return new ModelAndView("redirect:/Reports");
    }
}
