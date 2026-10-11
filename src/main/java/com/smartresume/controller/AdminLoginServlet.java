package com.smartresume.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin")
public class AdminLoginServlet extends HttpServlet {

    private static final String ADMIN_EMAIL =
            "admin@smartresume.com";

    private static final String ADMIN_PASSWORD =
            "Admin@123";


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session != null &&
                Boolean.TRUE.equals(
                        session.getAttribute("isAdmin"))) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/admin/dashboard"
            );

            return;
        }
        request.getRequestDispatcher(
        "/WEB-INF/views/admin/admin-login.jsp"
)
.forward(
                request,
                response
        );
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");


        if (email != null &&
                password != null &&
                ADMIN_EMAIL.equalsIgnoreCase(
                        email.trim()
                ) &&
                ADMIN_PASSWORD.equals(password)) {

            HttpSession session =
                    request.getSession(true);

            session.setAttribute(
                    "isAdmin",
                    true
            );

            session.setAttribute(
                    "adminEmail",
                    ADMIN_EMAIL
            );

            response.sendRedirect(
                    request.getContextPath() +
                    "/admin/dashboard"
            );

            return;
        }


        response.sendRedirect(
                request.getContextPath() +
                "/admin?error=true"
        );
    }
}