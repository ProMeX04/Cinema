package com.cinema.model;

import java.util.Date;

/**
 * Represents a scheduled movie showtime.
 */
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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Movie getMovie() {
        return movie;
    }

    public void setMovie(Movie movie) {
        this.movie = movie;
    }

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
    }
}
