package com.ogdencity.wmnsfconfidentialfunds.enums;

/**
 * Created by Tyler on 7/24/2015.
 */
public enum TransactionType {
    EXPENDITURE {public String toString(){
        return "EXPENDITURE";
    }},
    END_OF_MONTH{public String toString(){
        return "END OF MONTH";
    }},
    INSERT {public String toString(){
        return "INSERT";
    }},
    TRANSFER {public String toString(){
        return "TRANSFER";
    }}
}
