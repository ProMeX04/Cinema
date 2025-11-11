package com.cinema.model;

import lombok.Data;

@Data
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
    
}
