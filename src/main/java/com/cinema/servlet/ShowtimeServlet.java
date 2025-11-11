package com.cinema.servlet;

import com.cinema.dao.MovieDAO;
import com.cinema.dao.ShowtimeDAO;
import com.cinema.model.Movie;
import com.cinema.model.Room;
import com.cinema.model.Showtime;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.List;

@WebServlet(name = "ShowtimeServlet", urlPatterns = { "/showtimes" })
public class ShowtimeServlet extends HttpServlet {

    private final ShowtimeDAO showtimeDAO = new ShowtimeDAO();
    private final MovieDAO movieDAO = new MovieDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "availableRooms":
                handleAvailableRooms(request, response);
                break;
            case "prepare":
                prepareSchedule(request, response);
                break;
            default:
                listShowtimes(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.equals("create")) {
            createShowtime(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unsupported action");
        }
    }

    private void listShowtimes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Showtime> showtimes = showtimeDAO.findCurrentShowtime();
        request.setAttribute("showtimes", showtimes);
        // Nếu được include từ JSP (có parameter include=true) thì không forward
        if (request.getParameter("include") == null) {
            request.getRequestDispatcher("/ManageShowtime.jsp").forward(request, response);
        }
    }

    private void prepareSchedule(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("moviesNowShowing", movieDAO.getMovieNowShowing());
        request.setAttribute("availableRooms", showtimeDAO.findRoomAvailable());
        // Nếu được include từ JSP (có parameter include=true) thì không forward
        if (request.getParameter("include") == null) {
            request.getRequestDispatcher("/ScheduleShowtime.jsp").forward(request, response);
        }
    }

    private void handleAvailableRooms(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Room> rooms = showtimeDAO.findRoomAvailable();

        // Nếu được include từ JSP thì set attribute, không trả về JSON
        if (request.getParameter("include") != null) {
            request.setAttribute("availableRooms", rooms);
            return;
        }

        // Nếu không phải include thì trả về JSON
        response.setContentType("application/json;charset=UTF-8");
        try (PrintWriter writer = response.getWriter()) {
            writer.write("[");
            for (int i = 0; i < rooms.size(); i++) {
                Room room = rooms.get(i);
                writer.write(String.format("{\"id\":%d,\"name\":\"%s\",\"format\":\"%s\"}",
                        room.getId(), escapeJson(room.getName()), escapeJson(defaultString(room.getFormat()))));
                if (i < rooms.size() - 1) {
                    writer.write(",");
                }
            }
            writer.write("]");
        }
    }

    private void createShowtime(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            LocalDate date = LocalDate.parse(request.getParameter("showDate"));
            LocalTime startTime = LocalTime.parse(request.getParameter("startTime"));
            LocalTime endTime = LocalTime.parse(request.getParameter("endTime"));
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            int movieId = Integer.parseInt(request.getParameter("movieId"));

            if (endTime.isBefore(startTime) || endTime.equals(startTime)) {
                request.setAttribute("errorMessage", "Giờ kết thúc phải sau giờ bắt đầu.");
                prepareSchedule(request, response);
                return;
            }

            Room room = new Room();
            room.setId(roomId);

            Movie movie = new Movie();
            movie.setId(movieId);

            Showtime showtime = new Showtime();
            LocalDateTime startDateTime = LocalDateTime.of(date, startTime);
            LocalDateTime endDateTime = LocalDateTime.of(date, endTime);
            java.util.Date startDate = java.util.Date.from(startDateTime.atZone(ZoneId.systemDefault()).toInstant());
            java.util.Date endDate = java.util.Date.from(endDateTime.atZone(ZoneId.systemDefault()).toInstant());

            if (!showtimeDAO.isRoomAvailable(roomId, startDate, endDate)) {
                request.setAttribute("errorMessage",
                        "Phòng đã được đặt trong khung giờ này. Vui lòng chọn phòng hoặc khung giờ khác.");
                prepareSchedule(request, response);
                return;
            }

            showtime.setStartTime(startDate);
            showtime.setEndTime(endDate);
            showtime.setStatus("Scheduled");
            showtime.setRoom(room);
            showtime.setMovie(movie);

            showtimeDAO.save(showtime);
            request.setAttribute("successMessage", "Tạo lịch chiếu thành công");
        } catch (Exception ex) {
            request.setAttribute("errorMessage", "Không thể tạo lịch chiếu: " + ex.getMessage());
        }

        prepareSchedule(request, response);
    }

    private String escapeJson(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\\", "\\\\").replace("\"", "\\\"");
    }

    private String defaultString(String value) {
        return value == null ? "" : value;
    }
}
