package com.cinema.model;

import java.util.Date;

/**
 * Represents a membership card issued to a customer.
 */
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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public Date getIssueAt() {
        return issueAt;
    }

    public void setIssueAt(Date issueAt) {
        this.issueAt = issueAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
