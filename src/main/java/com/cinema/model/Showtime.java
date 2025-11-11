package com.cinema.model;

import java.util.Date;

import lombok.Data;

@Data
public class Showtime {
    private int id;
    private Date startTime;
    private Date endTime;
    private String status;
    private Movie movie;
    private Room room;

    public Showtime() {
    }

    public Showtime(int id, Date startTime, Date endTime, String status, Movie movie, Room room) {
        this.id = id;
        this.startTime = startTime;
        this.endTime = endTime;
        this.status = status;
        this.movie = movie;
        this.room = room;
    }
    

}
