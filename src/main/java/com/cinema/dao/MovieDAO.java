package com.cinema.dao;

import com.cinema.model.Movie;
import com.cinema.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data access layer for the {@link Movie} entity.
 */
public class MovieDAO {

    private static final String BASE_SELECT =
            "SELECT id, title, description, duration, rating, releaseDate, status, poster, trailer, genre, language FROM Movie";
    private static final String SELECT_BY_TITLE = BASE_SELECT + " WHERE title LIKE ?";
    private static final String SELECT_BY_ID = BASE_SELECT + " WHERE id = ?";
    private static final String SELECT_ALL = BASE_SELECT + " ORDER BY releaseDate DESC";
    private static final String SELECT_NOW_SHOWING = BASE_SELECT +
            " WHERE status IN ('Now Showing', 'Đang chiếu', 'Đang Chiếu') ORDER BY releaseDate DESC";

    /**
     * Finds movies whose title contains the provided keyword.
     *
     * @param keyword keyword provided by the user
     * @return list of matching movies
     */
    public List<Movie> findMovieByTitle(String keyword) {
        List<Movie> movies = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DBConnection.getConnection();
            statement = connection.prepareStatement(SELECT_BY_TITLE);
            statement.setString(1, "%" + keyword + "%");
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                movies.add(mapMovie(resultSet));
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Không thể tìm kiếm phim", ex);
        } finally {
            closeResources(resultSet, statement, connection);
        }
        return movies;
    }

    /**
     * Retrieves a movie by its identifier.
     *
     * @param id movie identifier
     * @return movie or null if not found
     */
    public Movie getMovieById(int id) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DBConnection.getConnection();
            statement = connection.prepareStatement(SELECT_BY_ID);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return mapMovie(resultSet);
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Không thể tải chi tiết phim", ex);
        } finally {
            closeResources(resultSet, statement, connection);
        }
        return null;
    }

    /**
     * Retrieves all movies in the catalogue.
     *
     * @return list of all movies
     */
    public List<Movie> findAllMovie() {
        List<Movie> movies = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DBConnection.getConnection();
            statement = connection.prepareStatement(SELECT_ALL);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                movies.add(mapMovie(resultSet));
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Không thể tải danh sách phim", ex);
        } finally {
            closeResources(resultSet, statement, connection);
        }
        return movies;
    }

    /**
     * Retrieves all movies currently marked as now showing.
     *
     * @return list of movies currently showing
     */
    public List<Movie> findMovieNowShowing() {
        List<Movie> movies = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DBConnection.getConnection();
            statement = connection.prepareStatement(SELECT_NOW_SHOWING);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                movies.add(mapMovie(resultSet));
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Không thể tải danh sách phim đang chiếu", ex);
        } finally {
            closeResources(resultSet, statement, connection);
        }
        return movies;
    }

    private Movie mapMovie(ResultSet rs) throws SQLException {
        Movie movie = new Movie();
        movie.setId(rs.getInt("id"));
        movie.setTitle(rs.getString("title"));
        movie.setDescription(rs.getString("description"));
        movie.setDuration(rs.getDouble("duration"));
        movie.setRating(rs.getDouble("rating"));
        java.sql.Date releaseDate = rs.getDate("releaseDate");
        if (releaseDate != null) {
            movie.setReleaseDate(new java.util.Date(releaseDate.getTime()));
        }
        movie.setStatus(rs.getString("status"));
        movie.setPoster(rs.getString("poster"));
        movie.setTrailer(rs.getString("trailer"));
        movie.setGenre(rs.getString("genre"));
        movie.setLanguage(rs.getString("language"));
        return movie;
    }

    private void closeResources(ResultSet rs, PreparedStatement stmt, Connection connection) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException ignored) {
            }
        }
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException ignored) {
            }
        }
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException ignored) {
            }
        }
    }
}
