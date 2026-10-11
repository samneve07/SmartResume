package com.smartresume.controller;

import java.io.IOException;
import java.sql.SQLException;

import com.smartresume.dao.UserDAO;
import com.smartresume.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/WEB-INF/views/auth/register.jsp"
        ).forward(request, response);
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");


        String fullName =
                request.getParameter("fullName");

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        String confirmPassword =
                request.getParameter("confirmPassword");


        if (fullName == null ||
                email == null ||
                password == null ||
                confirmPassword == null) {

            request.setAttribute(
                    "error",
                    "Please fill all fields."
            );

            forwardRegister(request, response);
            return;
        }


        fullName = fullName.trim();
        email = email.trim().toLowerCase();


        if (fullName.length() < 2) {

            request.setAttribute(
                    "error",
                    "Please enter a valid full name."
            );

            forwardRegister(request, response);
            return;
        }


        if (email.length() < 5 ||
                !email.contains("@")) {

            request.setAttribute(
                    "error",
                    "Please enter a valid email address."
            );

            forwardRegister(request, response);
            return;
        }


        if (password.length() < 8) {

            request.setAttribute(
                    "error",
                    "Password must contain at least 8 characters."
            );

            forwardRegister(request, response);
            return;
        }


        if (!password.equals(confirmPassword)) {

            request.setAttribute(
                    "error",
                    "Passwords do not match."
            );

            forwardRegister(request, response);
            return;
        }


        try {

            if (userDAO.emailExists(email)) {

                request.setAttribute(
                        "error",
                        "An account with this email already exists."
                );

                forwardRegister(request, response);
                return;
            }


            String hashedPassword =
                    PasswordUtil.hashPassword(password);


            boolean registered =
                    userDAO.registerUser(
                            fullName,
                            email,
                            hashedPassword
                    );


            if (registered) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/login?registered=true"
                );

                return;
            }


            request.setAttribute(
                    "error",
                    "Registration could not be completed."
            );

            forwardRegister(request, response);


        } catch (SQLException e) {

            e.printStackTrace();

            /*
             * TEMPORARY DIAGNOSTIC MESSAGE.
             * This will show the actual MySQL problem.
             */

            request.setAttribute(
                    "error",
                    "Database error: " + e.getMessage()
            );

            forwardRegister(request, response);


        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "error",
                    "Application error: " + e.getMessage()
            );

            forwardRegister(request, response);
        }
    }


    private void forwardRegister(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/WEB-INF/views/auth/register.jsp"
        ).forward(request, response);
    }
}