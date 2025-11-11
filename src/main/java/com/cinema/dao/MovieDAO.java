package com.cinema.dao;

import com.cinema.model.Genre;
import com.cinema.model.Movie;
import com.cinema.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MovieDAO {

    private static final String BASE_SELECT = "SELECT id, title, description, duration, rating, releaseDate, status, poster, imageUrl, trailer, language FROM Movie";
    private static final String SELECT_BY_TITLE = BASE_SELECT + " WHERE title LIKE ?";
    private static final String SELECT_BY_ID = BASE_SELECT + " WHERE id = ?";
    private static final String SELECT_ALL = BASE_SELECT + " ORDER BY releaseDate DESC";
    private static final String SELECT_NOW_SHOWING = BASE_SELECT +
            " WHERE status IN ('Now Showing', 'Đang chiếu', 'Đang Chiếu') ORDER BY releaseDate DESC";

    private static final String INSERT_MOVIE_GENRE = "INSERT INTO Movie_Genre (MovieId, GenreId) VALUES (?, ?)";
    private static final String DELETE_MOVIE_GENRE = "DELETE FROM Movie_Genre WHERE MovieId = ? AND GenreId = ?";
    private static final String DELETE_ALL_MOVIE_GENRES = "DELETE FROM Movie_Genre WHERE MovieId = ?";

    private GenreDAO genreDAO;

    public MovieDAO() {
        this.genreDAO = new GenreDAO();
    }

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

    public List<Movie> getMovieNowShowing() {
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

    public List<Movie> findMovieNowShowing() {
        return getMovieNowShowing();
    }

    public boolean addGenreToMovie(int movieId, int genreId) {
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = DBConnection.getConnection();
            statement = connection.prepareStatement(INSERT_MOVIE_GENRE);
            statement.setInt(1, movieId);
            statement.setInt(2, genreId);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            throw new RuntimeException("Không thể thêm thể loại cho phim", ex);
        } finally {
            closeResources(null, statement, connection);
        }
    }

    public boolean removeGenreFromMovie(int movieId, int genreId) {
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = DBConnection.getConnection();
            statement = connection.prepareStatement(DELETE_MOVIE_GENRE);
            statement.setInt(1, movieId);
            statement.setInt(2, genreId);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            throw new RuntimeException("Không thể xóa thể loại khỏi phim", ex);
        } finally {
            closeResources(null, statement, connection);
        }
    }

    public boolean updateMovieGenres(int movieId, List<Integer> genreIds) {
        Connection connection = null;
        PreparedStatement deleteStatement = null;
        PreparedStatement insertStatement = null;

        try {
            connection = DBConnection.getConnection();
            connection.setAutoCommit(false);

            deleteStatement = connection.prepareStatement(DELETE_ALL_MOVIE_GENRES);
            deleteStatement.setInt(1, movieId);
            deleteStatement.executeUpdate();

            if (genreIds != null && !genreIds.isEmpty()) {
                insertStatement = connection.prepareStatement(INSERT_MOVIE_GENRE);
                for (Integer genreId : genreIds) {
                    insertStatement.setInt(1, movieId);
                    insertStatement.setInt(2, genreId);
                    insertStatement.addBatch();
                }
                insertStatement.executeBatch();
            }

            connection.commit();
            return true;
        } catch (SQLException ex) {
            try {
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException rollbackEx) {
                throw new RuntimeException("Không thể rollback transaction", rollbackEx);
            }
            throw new RuntimeException("Không thể cập nhật thể loại cho phim", ex);
        } finally {
            closeResources(null, deleteStatement, null);
            closeResources(null, insertStatement, null);
            if (connection != null) {
                try {
                    connection.setAutoCommit(true);
                    connection.close();
                } catch (SQLException ignored) {
                }
            }
        }
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
        movie.setImageUrl(rs.getString("imageUrl"));
        movie.setTrailer(rs.getString("trailer"));
        movie.setLanguage(rs.getString("language"));

        List<Genre> genres = genreDAO.findByMovieId(movie.getId());
        movie.setGenres(genres);

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
