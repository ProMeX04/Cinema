package com.cinema.model;

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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getSeatType() {
        return seatType;
    }

    public void setSeatType(String seatType) {
        this.seatType = seatType;
    }

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
    }
}
