package com.cinema.model;

/**
 * Represents a physical screening room in the cinema.
 */
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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getFormat() {
        return format;
    }

    public void setFormat(String format) {
        this.format = format;
    }

    public Cinema getCinema() {
        return cinema;
    }

    public void setCinema(Cinema cinema) {
        this.cinema = cinema;
    }

    @Override
    public String toString() {
        return name + " (" + capacity + " ghế)";
    }
}
