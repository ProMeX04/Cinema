package com.cinema.model;

import java.util.Date;

import lombok.Data;

@Data
public class Order {
    private int id;
    private Date orderTime;
    private String status;
    private double totalAmount;
    private User user;

    public Order() {
    }

    public Order(int id, Date orderTime, String status, double totalAmount, User user) {
        this.id = id;
        this.orderTime = orderTime;
        this.status = status;
        this.totalAmount = totalAmount;
        this.user = user;
    }
    

}
