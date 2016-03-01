package com.ogdencity.wmnsfconfidentialfunds.enums;

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
