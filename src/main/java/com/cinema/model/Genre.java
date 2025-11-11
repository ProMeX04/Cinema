package com.cinema.model;

import lombok.Data;

@Data
public class Genre {
    private int id;
    private String name;
    private String description;

    public Genre() {
    }

    public Genre(int id, String name, String description) {
        this.id = id;
        this.name = name;
        this.description = description;
    }

    @Override
    public String toString() {
        return name;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Genre genre = (Genre) obj;
        return id == genre.id;
    }

    @Override
    public int hashCode() {
        return Integer.hashCode(id);
    }
}

