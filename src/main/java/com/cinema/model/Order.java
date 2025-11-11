package com.cinema.model;

import java.util.Date;

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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(Date orderTime) {
        this.orderTime = orderTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
