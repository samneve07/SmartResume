package com.smartresume.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.smartresume.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);


        if (session == null ||
                !Boolean.TRUE.equals(
                        session.getAttribute("isAdmin"))) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/admin"
            );

            return;
        }


        int totalUsers =
                getCount(
                        "SELECT COUNT(*) FROM users"
                );


        int totalResumes =
                getCount(
                        "SELECT COUNT(*) FROM resumes"
                );


        int totalTemplates = 12;


        int recentUsers =
                getCount(
                        "SELECT COUNT(*) FROM users " +
                        "WHERE created_at >= DATE_SUB(NOW(), INTERVAL 7 DAY)"
                );


        request.setAttribute(
                "totalUsers",
                totalUsers
        );

        request.setAttribute(
                "totalResumes",
                totalResumes
        );

        request.setAttribute(
                "totalTemplates",
                totalTemplates
        );

        request.setAttribute(
                "recentUsers",
                recentUsers
        );
request.getRequestDispatcher(
        "/WEB-INF/views/admin/admin-dashboard.jsp"
)
.forward(
                request,
                response
        );
    }


    private int getCount(String sql) {

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql);

                ResultSet result =
                        statement.executeQuery()
        ) {

            if (result.next()) {
                return result.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
}