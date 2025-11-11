package com.cinema.dao;

import com.cinema.model.Cinema;
import com.cinema.model.Genre;
import com.cinema.model.Movie;
import com.cinema.model.Room;
import com.cinema.model.Showtime;
import com.cinema.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Handles database interaction for showtime operations.
 */
public class ShowtimeDAO {

    private static final String SELECT_CURRENT =
            "SELECT st.id, st.startTime, st.endTime, st.status, " +
                    "r.id AS room_id, r.name AS room_name, r.capacity, r.description AS room_description, r.format, " +
                    "c.id AS cinema_id, c.name AS cinema_name, c.address AS cinema_address, c.description AS cinema_description, " +
                    "m.id AS movie_id, m.title AS movie_title, m.poster AS movie_poster, m.duration AS movie_duration " +
                    "FROM ShowTime st " +
                    "JOIN Room r ON st.RoomId = r.id " +
                    "JOIN Cinema c ON r.CinemaId = c.id " +
                    "JOIN Movie m ON st.MovieId = m.id " +
                    "WHERE st.startTime >= CURRENT_DATE() " +
                    "ORDER BY st.startTime";

    private GenreDAO genreDAO;

    public ShowtimeDAO() {
        this.genreDAO = new GenreDAO();
    }

    private static final String SELECT_AVAILABLE_ROOMS =
            "SELECT r.id AS room_id, r.name AS room_name, r.capacity, r.description AS room_description, r.format, " +
                    "c.id AS cinema_id, c.name AS cinema_name, c.address AS cinema_address, c.description AS cinema_description " +
                    "FROM Room r JOIN Cinema c ON r.CinemaId = c.id ORDER BY r.name";

    private static final String INSERT_SHOWTIME =
            "INSERT INTO ShowTime (startTime, endTime, status, MovieId, RoomId) VALUES (?, ?, ?, ?, ?)";

    private static final String CHECK_ROOM_AVAILABILITY =
            "SELECT COUNT(*) FROM ShowTime WHERE RoomId = ? AND status != 'Cancelled' " +
                    "AND NOT (endTime <= ? OR startTime >= ?)";

    /**
     * Checks if a room is available for a given time slot.
     *
     * @param roomId room identifier
     * @param startTime start time of the showtime
     * @param endTime end time of the showtime
     * @return true if room is available, false otherwise
     */
    public boolean isRoomAvailable(int roomId, Date startTime, Date endTime) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DBConnection.getConnection();
            statement = connection.prepareStatement(CHECK_ROOM_AVAILABILITY);
            statement.setInt(1, roomId);
            Timestamp start = new Timestamp(startTime.getTime());
            Timestamp end = new Timestamp(endTime.getTime());
            statement.setTimestamp(2, start);
            statement.setTimestamp(3, end);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1) == 0;
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Không thể kiểm tra phòng trống", ex);
        } finally {
            closeResources(resultSet, statement, connection);
        }
        return false;
    }

    /**
     * Loads current and upcoming showtimes with their movie and room metadata.
     *
     * @return list of showtimes
     */
    public List<Showtime> findCurrentShowtime() {
        List<Showtime> showtimes = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DBConnection.getConnection();
            statement = connection.prepareStatement(SELECT_CURRENT);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                showtimes.add(mapShowtime(resultSet));
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Không thể tải lịch chiếu", ex);
        } finally {
            closeResources(resultSet, statement, connection);
        }
        return showtimes;
    }

    /**
     * Finds rooms that are available to be scheduled.
     *
     * @return list of available rooms
     */
    public List<Room> findAvailableRoom() {
        List<Room> rooms = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DBConnection.getConnection();
            statement = connection.prepareStatement(SELECT_AVAILABLE_ROOMS);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                rooms.add(mapRoom(resultSet));
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Không thể tải danh sách phòng trống", ex);
        } finally {
            closeResources(resultSet, statement, connection);
        }
        return rooms;
    }

    /**
     * Persists a new showtime in the database.
     *
     * @param showtime showtime to save
     * @return generated identifier
     */
    public int save(Showtime showtime) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet generatedKeys = null;
        try {
            connection = DBConnection.getConnection();
            statement = connection.prepareStatement(INSERT_SHOWTIME, Statement.RETURN_GENERATED_KEYS);
            statement.setTimestamp(1, new Timestamp(showtime.getStartTime().getTime()));
            statement.setTimestamp(2, new Timestamp(showtime.getEndTime().getTime()));
            statement.setString(3, showtime.getStatus());
            statement.setInt(4, showtime.getMovie().getId());
            statement.setInt(5, showtime.getRoom().getId());
            statement.executeUpdate();
            generatedKeys = statement.getGeneratedKeys();
            if (generatedKeys.next()) {
                return generatedKeys.getInt(1);
            }
            return -1;
        } catch (SQLException ex) {
            throw new RuntimeException("Không thể lưu lịch chiếu", ex);
        } finally {
            closeResources(generatedKeys, statement, connection);
        }
    }

    private Showtime mapShowtime(ResultSet rs) throws SQLException {
        Showtime showtime = new Showtime();
        showtime.setId(rs.getInt("id"));
        Timestamp start = rs.getTimestamp("startTime");
        if (start != null) {
            showtime.setStartTime(new Date(start.getTime()));
        }
        Timestamp end = rs.getTimestamp("endTime");
        if (end != null) {
            showtime.setEndTime(new Date(end.getTime()));
        }
        showtime.setStatus(rs.getString("status"));

        Room room = mapRoom(rs);
        showtime.setRoom(room);

        Movie movie = new Movie();
        movie.setId(rs.getInt("movie_id"));
        movie.setTitle(rs.getString("movie_title"));
        movie.setPoster(rs.getString("movie_poster"));
        movie.setDuration(rs.getDouble("movie_duration"));
        
        // Load genres for this movie
        List<Genre> genres = genreDAO.findByMovieId(movie.getId());
        movie.setGenres(genres);
        
        showtime.setMovie(movie);
        return showtime;
    }

    private Room mapRoom(ResultSet rs) throws SQLException {
        Room room = new Room();
        room.setId(rs.getInt("room_id"));
        room.setName(rs.getString("room_name"));
        room.setCapacity(rs.getInt("capacity"));
        room.setDescription(rs.getString("room_description"));
        room.setFormat(rs.getString("format"));

        Cinema cinema = new Cinema();
        cinema.setId(rs.getInt("cinema_id"));
        cinema.setName(rs.getString("cinema_name"));
        cinema.setAddress(rs.getString("cinema_address"));
        cinema.setDescription(rs.getString("cinema_description"));
        room.setCinema(cinema);
        return room;
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
