
package com.smartresume.controller;

import java.io.IOException;
import java.sql.SQLException;

import com.smartresume.dao.UserDAO;
import com.smartresume.dao.UserDAO.UserData;
import com.smartresume.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/settings")
public class SettingsServlet extends HttpServlet {
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

        request.getRequestDispatcher("/WEB-INF/views/account/settings.jsp")
               .forward(request, response);
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

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (currentPassword == null || newPassword == null || confirmPassword == null
                || currentPassword.isEmpty() || newPassword.isEmpty()
                || confirmPassword.isEmpty()) {
            request.setAttribute("error", "Please fill in all password fields.");
            doGet(request, response);
            return;
        }

        if (newPassword.length() < 8 || newPassword.length() > 128) {
            request.setAttribute("error", "New password must be 8–128 characters.");
            doGet(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "New password and confirmation do not match.");
            doGet(request, response);
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

            if (!PasswordUtil.verifyPassword(currentPassword, user.getPassword())) {
                request.setAttribute("error", "Current password is incorrect.");
                doGet(request, response);
                return;
            }

            if (PasswordUtil.verifyPassword(newPassword, user.getPassword())) {
                request.setAttribute("error", "Choose a different password.");
                doGet(request, response);
                return;
            }

            String hashedPassword = PasswordUtil.hashPassword(newPassword);

            if (userDAO.updatePassword(userId, hashedPassword)) {
                request.setAttribute("success", "Password changed successfully.");
            } else {
                request.setAttribute("error", "Password could not be changed.");
            }

            doGet(request, response);

        } catch (SQLException | ClassCastException e) {
            throw new ServletException("Unable to update password.", e);
        }
    }
}