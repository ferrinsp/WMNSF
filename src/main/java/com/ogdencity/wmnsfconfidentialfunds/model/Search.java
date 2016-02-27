package com.ogdencity.wmnsfconfidentialfunds.model;

import com.ogdencity.wmnsfconfidentialfunds.enums.TransactionType;

import java.util.Date;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotBlank;

/**
 * Created by Tyler on 7/24/2015.
 */
public class Search {
    long userId;
    @NotBlank(message = "Must have transaction type")
    @Pattern(regexp = "{A-Za-z}", message = "Invalid input")
    TransactionType transactionType;
    @NotBlank
    Date startDate;
    @NotBlank
    Date endDate;
    boolean credit;
    boolean debit;
    boolean operator;

    public boolean isCredit() {
        return credit;
    }

    public void setCredit(boolean credit) {
        this.credit = credit;
    }

    public boolean isDebit() {
        return debit;
    }

    public void setDebit(boolean debit) {
        this.debit = debit;
    }

    public boolean isOperator() {
        return operator;
    }

    public void setOperator(boolean operator) {
        this.operator = operator;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public TransactionType getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(TransactionType transactionType) {
        this.transactionType = transactionType;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
}
