package com.cinema.model;

import lombok.Data;

@Data
public class Cinema {
    private int id;
    private String name;
    private String address;
    private String description;

    public Cinema() {
    }

    public Cinema(int id, String name, String address, String description) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.description = description;
    }
}
