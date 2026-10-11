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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);


        if (session != null &&
                session.getAttribute("userId") != null) {

            response.sendRedirect(
                    request.getContextPath() + "/dashboard"
            );

            return;
        }


        if ("true".equals(
                request.getParameter("registered"))) {

            request.setAttribute(
                    "success",
                    "Account created successfully. Please login."
            );
        }


        request.getRequestDispatcher(
                "/WEB-INF/views/auth/login.jsp"
        ).forward(request, response);
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");


        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");


        if (email == null ||
                password == null ||
                email.trim().isEmpty() ||
                password.isEmpty()) {

            request.setAttribute(
                    "error",
                    "Please enter your email and password."
            );

            forwardLogin(request, response);
            return;
        }


        email = email.trim().toLowerCase();


        try {

            UserData user =
                    userDAO.getUserByEmail(email);


            if (user == null) {

                request.setAttribute(
                        "error",
                        "No account found with this email."
                );

                forwardLogin(request, response);
                return;
            }


            boolean validPassword =
                    PasswordUtil.verifyPassword(
                            password,
                            user.getPassword()
                    );


            if (!validPassword) {

                request.setAttribute(
                        "error",
                        "Incorrect password. Please try again."
                );

                forwardLogin(request, response);
                return;
            }


            HttpSession session =
                    request.getSession(true);


            session.setAttribute(
                    "userId",
                    user.getUserId()
            );

            session.setAttribute(
                    "fullName",
                    user.getFullName()
            );

            session.setAttribute(
                    "email",
                    user.getEmail()
            );


            response.sendRedirect(
                    request.getContextPath()
                            + "/dashboard"
            );


        } catch (SQLException e) {

            e.printStackTrace();

            request.setAttribute(
                    "error",
                    "Database error: " + e.getMessage()
            );

            forwardLogin(request, response);


        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "error",
                    "Application error: " + e.getMessage()
            );

            forwardLogin(request, response);
        }
    }


    private void forwardLogin(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/WEB-INF/views/auth/login.jsp"
        ).forward(request, response);
    }
}