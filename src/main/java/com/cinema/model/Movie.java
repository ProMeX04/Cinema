package com.cinema.model;

import java.util.Date;

/**
 * Represents a movie that can be displayed in the cinema system.
 */
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
    private String genre;
    private String language;

    public Movie() {
    }

    public Movie(int id, String title, String description, double duration, double rating,
                 Date releaseDate, String status, String poster, String trailer,
                 String genre, String language) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.duration = duration;
        this.rating = rating;
        this.releaseDate = releaseDate;
        this.status = status;
        this.poster = poster;
        this.trailer = trailer;
        this.genre = genre;
        this.language = language;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getDuration() {
        return duration;
    }

    public void setDuration(double duration) {
        this.duration = duration;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    public String getTrailer() {
        return trailer;
    }

    public void setTrailer(String trailer) {
        this.trailer = trailer;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }
}
