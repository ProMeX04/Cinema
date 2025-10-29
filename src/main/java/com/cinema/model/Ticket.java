package com.cinema.model;

/**
 * Represents a ticket purchased by a customer.
 */
public class Ticket {
    private int id;
    private double price;
    private String status;
    private Order order;
    private Seat seat;
    private Showtime showtime;

    public Ticket() {
    }

    public Ticket(int id, double price, String status, Order order, Seat seat, Showtime showtime) {
        this.id = id;
        this.price = price;
        this.status = status;
        this.order = order;
        this.seat = seat;
        this.showtime = showtime;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
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

    public Seat getSeat() {
        return seat;
    }

    public void setSeat(Seat seat) {
        this.seat = seat;
    }

    public Showtime getShowtime() {
        return showtime;
    }

    public void setShowtime(Showtime showtime) {
        this.showtime = showtime;
    }
}
