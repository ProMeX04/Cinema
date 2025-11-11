package com.cinema.model;

import lombok.Data;

@Data
public class User {
    private int id;
    private String fullName;
    private String username;
    private String password;
    private String email;
    private String phone;
    private String role;
    private String note;

    public User() {
    }

    public User(int id, String fullName, String username, String password, String email,
                String phone, String role, String note) {
        this.id = id;
        this.fullName = fullName;
        this.username = username;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.role = role;
        this.note = note;
    }
}
