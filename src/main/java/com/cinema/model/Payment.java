package com.cinema.model;

import java.util.Date;

/**
 * Represents a payment for an order.
 */
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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public Date getPaidAt() {
        return paidAt;
    }

    public void setPaidAt(Date paidAt) {
        this.paidAt = paidAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }
}
