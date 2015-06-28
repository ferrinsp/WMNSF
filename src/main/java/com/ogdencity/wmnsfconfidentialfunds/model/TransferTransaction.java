package com.ogdencity.wmnsfconfidentialfunds.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by Tyler on 6/4/2015.
 */
@Entity
@Table(name="transfer_transaction")
public class TransferTransaction implements Serializable {

    @Id
    @GeneratedValue( strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    private Date date;
    private String description;
    private double amount;

    @OneToOne @JoinColumn(name="debit_user_id")
    private User debitUser;

    @OneToOne @JoinColumn(name = "credit_user_id")
    private User creditUser;

    @OneToOne @JoinColumn(name = "operator_user_id")
    private User operatorUser;

    @OneToOne @JoinColumn(name = "fund_type_id")
    private FundType fundType;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public User getDebitUser() {
        return debitUser;
    }

    public void setDebitUser(User debitUser) {
        this.debitUser = debitUser;
    }

    public User getCreditUser() {
        return creditUser;
    }

    public void setCreditUser(User creditUser) {
        this.creditUser = creditUser;
    }

    public User getOperatorUser() {
        return operatorUser;
    }

    public void setOperatorUser(User operatorUser) {
        this.operatorUser = operatorUser;
    }

    public FundType getFundType() {
        return fundType;
    }

    public void setFundType(FundType fundType) {
        this.fundType = fundType;
    }
}
