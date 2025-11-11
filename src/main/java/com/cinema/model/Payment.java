package com.cinema.model;

import java.util.Date;

import lombok.Data;

@Data
public class Payment {
    private int id;
    private String method;
    private double amount;
    private Date paidAt;
    private String status;
    private Order order;

    public Payment() {
    }

    public Payment(int id, String method, double amount, Date paidAt, String status, Order order) {
        this.id = id;
        this.method = method;
        this.amount = amount;
        this.paidAt = paidAt;
        this.status = status;
        this.order = order;
    }
    
}
