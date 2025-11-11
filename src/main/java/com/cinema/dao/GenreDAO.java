package com.cinema.dao;

import com.cinema.model.Genre;
import com.cinema.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class GenreDAO {

    private static final String SELECT_ALL = "SELECT id, name, description FROM Genre ORDER BY name";
    private static final String SELECT_BY_ID = "SELECT id, name, description FROM Genre WHERE id = ?";
    private static final String SELECT_BY_MOVIE_ID = 
            "SELECT g.id, g.name, g.description FROM Genre g " +
            "INNER JOIN Movie_Genre mg ON g.id = mg.GenreId " +
            "WHERE mg.MovieId = ? ORDER BY g.name";

    public List<Genre> findAll() {
        List<Genre> genres = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DBConnection.getConnection();
            statement = connection.prepareStatement(SELECT_ALL);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                genres.add(mapGenre(resultSet));
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Không thể tải danh sách thể loại", ex);
        } finally {
            closeResources(resultSet, statement, connection);
        }
        return genres;
    }

    public Genre findById(int id) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DBConnection.getConnection();
            statement = connection.prepareStatement(SELECT_BY_ID);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return mapGenre(resultSet);
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Không thể tải thể loại", ex);
        } finally {
            closeResources(resultSet, statement, connection);
        }
        return null;
    }

    public List<Genre> findByMovieId(int movieId) {
        List<Genre> genres = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DBConnection.getConnection();
            statement = connection.prepareStatement(SELECT_BY_MOVIE_ID);
            statement.setInt(1, movieId);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                genres.add(mapGenre(resultSet));
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Không thể tải thể loại của phim", ex);
        } finally {
            closeResources(resultSet, statement, connection);
        }
        return genres;
    }

    private Genre mapGenre(ResultSet rs) throws SQLException {
        Genre genre = new Genre();
        genre.setId(rs.getInt("id"));
        genre.setName(rs.getString("name"));
        genre.setDescription(rs.getString("description"));
        return genre;
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

