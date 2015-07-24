package com.ogdencity.wmnsfconfidentialfunds.model;

/**
 * Created by Tyler on 7/24/2015.
 */
public enum TransactionType {
    TRANSFER {public String toString(){
        return "TRANSFER";
    }},
    EXPENDITURE {public String toString(){
        return "EXPENDITURE";
    }},
    INSERT {public String toString(){
        return "INSERT";
    }},
    END_OF_MONTH{public String toString(){
        return "END OF MONTH";
    }}
}
