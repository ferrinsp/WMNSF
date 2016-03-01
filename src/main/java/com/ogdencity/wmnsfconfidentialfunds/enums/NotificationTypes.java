package com.ogdencity.wmnsfconfidentialfunds.enums;

public enum NotificationTypes {
    SUCCESS {public String toString(){
        return "successNotification";
    }},
    INFO {public String toString(){
        return "infoNotification";
    }},
    WARNING {public String toString(){
        return "warningNotification";
    }},
    ERROR{public String toString(){
        return "errorNotification";
    }}
}
