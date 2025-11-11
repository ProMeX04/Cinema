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
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
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
        if (request.getParameter("include") == null) {
            request.getRequestDispatcher("/ManageShowtime.jsp").forward(request, response);
        }
    }

    private void prepareSchedule(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("moviesNowShowing", movieDAO.getMovieNowShowing());
        request.setAttribute("availableRooms", showtimeDAO.findRoomAvailable());
        if (request.getParameter("include") == null) {
            request.getRequestDispatcher("/ScheduleShowtime.jsp").forward(request, response);
        }
    }

    private void handleAvailableRooms(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Room> rooms;

        String startTimeStr = request.getParameter("startTime");
        String endTimeStr = request.getParameter("endTime");
        String dateStr = request.getParameter("date");

        if (startTimeStr != null && endTimeStr != null && dateStr != null) {
            try {
                String trimmedDate = dateStr.trim();
                if (!trimmedDate.matches("\\d{4}-\\d{2}-\\d{2}")) {
                    throw new IllegalArgumentException("Định dạng ngày không hợp lệ");
                }
                LocalDate date = LocalDate.parse(trimmedDate, DateTimeFormatter.ISO_LOCAL_DATE);

                String trimmedStartTime = startTimeStr.trim();
                String trimmedEndTime = endTimeStr.trim();
                if (!trimmedStartTime.matches("\\d{2}:\\d{2}") || !trimmedEndTime.matches("\\d{2}:\\d{2}")) {
                    throw new IllegalArgumentException("Định dạng giờ không hợp lệ");
                }
                LocalTime startTime = LocalTime.parse(trimmedStartTime);
                LocalTime endTime = LocalTime.parse(trimmedEndTime);

                LocalDateTime startDateTime = LocalDateTime.of(date, startTime);
                LocalDateTime endDateTime = LocalDateTime.of(date, endTime);
                java.util.Date startDate = java.util.Date
                        .from(startDateTime.atZone(ZoneId.systemDefault()).toInstant());
                java.util.Date endDate = java.util.Date.from(endDateTime.atZone(ZoneId.systemDefault()).toInstant());

                rooms = showtimeDAO.findRoomAvailable(startDate, endDate);
            } catch (DateTimeParseException | IllegalArgumentException e) {
                System.out.println("DEBUG: Error parsing date/time in handleAvailableRooms: " + e.getMessage());
                rooms = showtimeDAO.findRoomAvailable();
            } catch (Exception e) {
                System.out.println("DEBUG: Unexpected error in handleAvailableRooms: " + e.getMessage());
                rooms = showtimeDAO.findRoomAvailable();
            }
        } else {
            rooms = showtimeDAO.findRoomAvailable();
        }

        System.out.println("DEBUG: Found " + rooms.size() + " available rooms");
        for (Room r : rooms) {
            System.out.println("  Room: " + r.getName() + ", Format: '" + r.getFormat() + "'");
        }

        if (request.getParameter("include") != null) {
            request.setAttribute("availableRooms", rooms);
            return;
        }

        response.setContentType("application/json;charset=UTF-8");
        try (PrintWriter writer = response.getWriter()) {
            writer.write("[");
            for (int i = 0; i < rooms.size(); i++) {
                Room room = rooms.get(i);
                String name = room.getName() != null ? escapeJson(room.getName()) : "";
                String format = "";
                if (room.getFormat() != null &&
                        !room.getFormat().isEmpty() &&
                        !room.getFormat().equalsIgnoreCase("false") &&
                        !room.getFormat().equals("0")) {
                    format = escapeJson(room.getFormat());
                }
                int capacity = room.getCapacity();
                writer.write(String.format("{\"id\":%d,\"name\":\"%s\",\"format\":\"%s\",\"capacity\":%d}",
                        room.getId(), name, format, capacity));
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
            System.out.println("DEBUG: Creating showtime...");
            String showDateStr = request.getParameter("showDate");
            String startTimeStr = request.getParameter("startTime");
            String endTimeStr = request.getParameter("endTime");
            String roomIdStr = request.getParameter("roomId");
            String movieIdStr = request.getParameter("movieId");

            System.out.println(
                    "DEBUG: showDate=" + showDateStr + ", startTime=" + startTimeStr + ", endTime=" + endTimeStr);
            System.out.println("DEBUG: roomId=" + roomIdStr + ", movieId=" + movieIdStr);

            if (showDateStr == null || showDateStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Ngày chiếu không được để trống");
            }
            if (startTimeStr == null || startTimeStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Giờ bắt đầu không được để trống");
            }
            if (endTimeStr == null || endTimeStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Giờ kết thúc không được để trống");
            }
            if (roomIdStr == null || roomIdStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Phòng không được để trống");
            }
            if (movieIdStr == null || movieIdStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Phim không được để trống");
            }

            LocalDate date;
            try {
                String trimmedDate = showDateStr.trim();
                if (!trimmedDate.matches("\\d{4}-\\d{2}-\\d{2}")) {
                    throw new IllegalArgumentException(
                            "Định dạng ngày không hợp lệ. Vui lòng sử dụng định dạng YYYY-MM-DD (ví dụ: 2024-12-25)");
                }
                DateTimeFormatter dateFormatter = DateTimeFormatter.ISO_LOCAL_DATE;
                date = LocalDate.parse(trimmedDate, dateFormatter);

                if (date.isBefore(LocalDate.now())) {
                    throw new IllegalArgumentException("Ngày chiếu không được trong quá khứ");
                }
            } catch (DateTimeParseException e) {
                throw new IllegalArgumentException(
                        "Ngày chiếu không hợp lệ. Vui lòng kiểm tra lại định dạng ngày (YYYY-MM-DD)");
            }

            LocalTime startTime;
            LocalTime endTime;
            try {
                String trimmedStartTime = startTimeStr.trim();
                if (!trimmedStartTime.matches("\\d{2}:\\d{2}")) {
                    throw new IllegalArgumentException(
                            "Định dạng giờ bắt đầu không hợp lệ. Vui lòng sử dụng định dạng HH:mm (ví dụ: 14:30)");
                }
                startTime = LocalTime.parse(trimmedStartTime);
            } catch (DateTimeParseException e) {
                throw new IllegalArgumentException(
                        "Giờ bắt đầu không hợp lệ. Vui lòng kiểm tra lại định dạng giờ (HH:mm)");
            }

            try {
                String trimmedEndTime = endTimeStr.trim();
                if (!trimmedEndTime.matches("\\d{2}:\\d{2}")) {
                    throw new IllegalArgumentException(
                            "Định dạng giờ kết thúc không hợp lệ. Vui lòng sử dụng định dạng HH:mm (ví dụ: 16:30)");
                }
                endTime = LocalTime.parse(trimmedEndTime);
            } catch (DateTimeParseException e) {
                throw new IllegalArgumentException(
                        "Giờ kết thúc không hợp lệ. Vui lòng kiểm tra lại định dạng giờ (HH:mm)");
            }

            int roomId;
            int movieId;
            try {
                roomId = Integer.parseInt(roomIdStr.trim());
                if (roomId <= 0) {
                    throw new IllegalArgumentException("ID phòng không hợp lệ");
                }
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("ID phòng phải là một số hợp lệ");
            }

            try {
                movieId = Integer.parseInt(movieIdStr.trim());
                if (movieId <= 0) {
                    throw new IllegalArgumentException("ID phim không hợp lệ");
                }
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("ID phim phải là một số hợp lệ");
            }
            System.out.println("DEBUG: Parsed - MovieId=" + movieId + ", RoomId=" + roomId + ", Date=" + date);

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
            System.out.println("DEBUG: Showtime saved successfully, redirecting to ManageShowtime.jsp");
            String successMsg = java.net.URLEncoder.encode("Tạo lịch chiếu thành công", "UTF-8");
            String redirectUrl = request.getContextPath() + "/ManageShowtime.jsp?successMessage=" + successMsg;
            System.out.println("DEBUG: Redirect URL: " + redirectUrl);
            response.sendRedirect(redirectUrl);
            return;
        } catch (IllegalArgumentException ex) {
            System.out.println("DEBUG: Validation error: " + ex.getMessage());
            request.setAttribute("errorMessage", ex.getMessage());
            prepareSchedule(request, response);
        } catch (Exception ex) {
            System.out.println("DEBUG: Error creating showtime: " + ex.getMessage());
            ex.printStackTrace();
            String errorMsg = "Không thể tạo lịch chiếu. ";
            if (ex.getMessage() != null) {
                errorMsg += ex.getMessage();
            } else {
                errorMsg += "Vui lòng kiểm tra lại thông tin đã nhập.";
            }
            request.setAttribute("errorMessage", errorMsg);
            prepareSchedule(request, response);
        }
    }

    private String escapeJson(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\\", "\\\\").replace("\"", "\\\"");
    }

}
