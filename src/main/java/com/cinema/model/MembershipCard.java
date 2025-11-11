package com.cinema.model;

import java.util.Date;

import lombok.Data;

@Data
public class MembershipCard {
    private int id;
    private String cardNumber;
    private Date issueAt;
    private String status;
    private User user;

    public MembershipCard() {
    }

    public MembershipCard(int id, String cardNumber, Date issueAt, String status, User user) {
        this.id = id;
        this.cardNumber = cardNumber;
        this.issueAt = issueAt;
        this.status = status;
        this.user = user;
    }
    
}
