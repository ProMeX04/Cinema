package com.cinema.model;

import lombok.Data;

@Data   
public class Seat {
    private int id;
    private String position;
    private String seatType;
    private Room room;

    public Seat() {
    }

    public Seat(int id, String position, String seatType, Room room) {
        this.id = id;
        this.position = position;
        this.seatType = seatType;
        this.room = room;
    }
    
}
