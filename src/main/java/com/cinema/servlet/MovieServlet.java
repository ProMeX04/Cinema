package com.cinema.servlet;

import com.cinema.dao.MovieDAO;
import com.cinema.model.Movie;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "MovieServlet", urlPatterns = {"/movies"})
public class MovieServlet extends HttpServlet {

    private final MovieDAO movieDAO = new MovieDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "search";
        }

        switch (action) {
            case "detail":
                handleDetail(request, response);
                break;
            case "nowShowing":
                handleNowShowing(request, response);
                break;
            default:
                handleSearch(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleSearch(request, response);
    }

    private void handleSearch(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Movie> movies = keyword == null || keyword.isBlank()
                ? List.of()
                : movieDAO.findMovieByTitle(keyword.trim());

        if (movies.isEmpty() && keyword != null && !keyword.isBlank()) {
            request.setAttribute("message", "Không tìm thấy phim nào phù hợp với từ khóa của bạn.");
        }
        request.setAttribute("keyword", keyword);
        request.setAttribute("movies", movies);
        request.getRequestDispatcher("/SearchMovie.jsp").forward(request, response);
    }

    private void handleDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/SearchMovie.jsp");
            return;
        }
        try {
            int id = Integer.parseInt(idParam);
            Movie movie = movieDAO.getMovieById(id);
            if (movie == null) {
                request.setAttribute("errorMessage", "Phim không tồn tại hoặc đã bị xóa.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }
            request.setAttribute("movie", movie);
            request.getRequestDispatcher("/MovieDetail.jsp").forward(request, response);
        } catch (NumberFormatException ex) {
            request.setAttribute("errorMessage", "Mã phim không hợp lệ.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void handleNowShowing(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Movie> movies = movieDAO.getMovieNowShowing();
        if ("json".equalsIgnoreCase(request.getParameter("format"))) {
            response.setContentType("application/json;charset=UTF-8");
            try (PrintWriter writer = response.getWriter()) {
                writer.write("[");
                for (int i = 0; i < movies.size(); i++) {
                    Movie movie = movies.get(i);
                    writer.write(String.format("{\"id\":%d,\"title\":\"%s\",\"status\":\"%s\"}",
                            movie.getId(), escapeJson(defaultString(movie.getTitle())),
                            escapeJson(defaultString(movie.getStatus()))));
                    if (i < movies.size() - 1) {
                        writer.write(",");
                    }
                }
                writer.write("]");
            }
        } else {
            request.setAttribute("moviesNowShowing", movies);
            // Nếu được include từ JSP thì không forward (chỉ set attribute)
            String includeRequestUri = (String) request.getAttribute("javax.servlet.include.request_uri");
            if (includeRequestUri == null && request.getParameter("include") == null) {
                // Chỉ forward nếu không phải là include request
                try {
                    request.getRequestDispatcher("/ScheduleShowtime.jsp").forward(request, response);
                } catch (ServletException ex) {
                    throw new IOException(ex);
                }
            }
        }
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
