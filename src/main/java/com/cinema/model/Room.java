package com.cinema.model;

import lombok.Data;

@Data
public class Room {
    private int id;
    private String name;
    private int capacity;
    private String description;
    private String format;
    private Cinema cinema;

    public Room() {
    }

    public Room(int id, String name, int capacity, String description, String format, Cinema cinema) {
        this.id = id;
        this.name = name;
        this.capacity = capacity;
        this.description = description;
        this.format = format;
        this.cinema = cinema;
    }
    

    @Override
    public String toString() {
        return name + " (" + capacity + " ghế)";
    }
}
