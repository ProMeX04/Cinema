package com.cinema.servlet;

import com.cinema.dao.UserDAO;
import com.cinema.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "AuthServlet", urlPatterns = {"/auth"})
public class AuthServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null) {
            request.setAttribute("errorMessage", "Vui lòng nhập tên đăng nhập và mật khẩu.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        try {
            User user = userDAO.authenticate(username, password);
            if (user == null) {
                request.setAttribute("errorMessage", "Sai tên đăng nhập hoặc mật khẩu.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }

            HttpSession session = request.getSession(true);
            session.setAttribute("currentUser", user);
            String role = user.getRole();
            if ("Manager".equalsIgnoreCase(role)) {
                response.sendRedirect(request.getContextPath() + "/MainManager.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/Main.jsp");
            }
        } catch (RuntimeException ex) {
            request.setAttribute("errorMessage", ex.getMessage());
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
