
package com.smartresume.controller;

import java.io.IOException;
import java.sql.SQLException;

import com.smartresume.dao.UserDAO;
import com.smartresume.dao.UserDAO.UserData;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int userId = ((Number) session.getAttribute("userId")).intValue();
            UserData user = userDAO.getUserById(userId);

            if (user == null) {
                session.invalidate();
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            request.setAttribute("profileUser", user);
            request.getRequestDispatcher("/WEB-INF/views/account/profile.jsp")
                   .forward(request, response);

        } catch (SQLException | ClassCastException e) {
            throw new ServletException("Unable to load profile.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");

        if (fullName == null || email == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        fullName = fullName.trim();
        email = email.trim().toLowerCase();

        if (fullName.isEmpty() || fullName.length() > 100
                || email.length() > 254
                || !email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {
            request.setAttribute("error", "Please enter a valid name and email.");
            doGet(request, response);
            return;
        }

        try {
            int userId = ((Number) session.getAttribute("userId")).intValue();

            if (userDAO.emailExistsForAnotherUser(email, userId)) {
                request.setAttribute("error", "This email is already registered.");
                doGet(request, response);
                return;
            }

            if (userDAO.updateProfile(userId, fullName, email)) {
                session.setAttribute("fullName", fullName);
                session.setAttribute("email", email);
                response.sendRedirect(request.getContextPath() + "/profile?updated=1");
            } else {
                request.setAttribute("error", "Profile could not be updated.");
                doGet(request, response);
            }

        } catch (SQLException | ClassCastException e) {
            throw new ServletException("Unable to update profile.", e);
        }
    }
}
