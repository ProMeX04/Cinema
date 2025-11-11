package com.cinema.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class Movie {
    private int id;
    private String title;
    private String description;
    private double duration;
    private double rating;
    private Date releaseDate;
    private String status;
    private String poster;
    private String trailer;
    private List<Genre> genres;
    private String language;

    public Movie() {
        this.genres = new ArrayList<>();
    }

    public Movie(int id, String title, String description, double duration, double rating,
                 Date releaseDate, String status, String poster, String trailer,
                 String language) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.duration = duration;
        this.rating = rating;
        this.releaseDate = releaseDate;
        this.status = status;
        this.poster = poster;
        this.trailer = trailer;
        this.genres = new ArrayList<>();
        this.language = language;
    }
    
    public void addGenre(Genre genre) {
        if (genre != null && !this.genres.contains(genre)) {
            this.genres.add(genre);
        }
    }

    public String getGenresAsString() {
        if (genres == null || genres.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < genres.size(); i++) {
            if (i > 0) {
                sb.append(", ");
            }
            sb.append(genres.get(i).getName());
        }
        return sb.toString();
    }

    
}
