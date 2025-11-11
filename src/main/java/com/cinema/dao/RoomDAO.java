package com.cinema.dao;

import com.cinema.model.Cinema;
import com.cinema.model.Room;
import com.cinema.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {

    private static final String SELECT_ALL =
            "SELECT r.id AS room_id, r.name AS room_name, r.capacity, r.description AS room_description, r.format, " +
                    "c.id AS cinema_id, c.name AS cinema_name, c.address AS cinema_address, c.description AS cinema_description " +
                    "FROM Room r JOIN Cinema c ON r.CinemaId = c.id ORDER BY r.name";

    public List<Room> findAll() {
        List<Room> rooms = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try {
            connection = DBConnection.getConnection();
            statement = connection.prepareStatement(SELECT_ALL);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                rooms.add(mapRoom(resultSet));
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Không thể tải danh sách phòng", ex);
        } finally {
            closeResources(resultSet, statement, connection);
        }
        return rooms;
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
