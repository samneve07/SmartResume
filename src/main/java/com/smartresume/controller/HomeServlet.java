package com.smartresume.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import com.smartresume.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try (Connection connection = DBConnection.getConnection()) {

            response.getWriter().println(
                "<!DOCTYPE html>" +
                "<html>" +
                "<head>" +
                "<meta charset='UTF-8'>" +
                "<title>SmartResume</title>" +

                "<style>" +
                "body {" +
                "margin: 0;" +
                "font-family: Arial, sans-serif;" +
                "background: #0f172a;" +
                "color: white;" +
                "display: flex;" +
                "justify-content: center;" +
                "align-items: center;" +
                "height: 100vh;" +
                "}" +

                ".container {" +
                "text-align: center;" +
                "background: #1e293b;" +
                "padding: 50px;" +
                "border-radius: 20px;" +
                "box-shadow: 0 20px 50px rgba(0,0,0,0.4);" +
                "}" +

                "h1 {" +
                "font-size: 42px;" +
                "margin-bottom: 20px;" +
                "}" +

                ".success {" +
                "color: #22c55e;" +
                "font-size: 24px;" +
                "font-weight: bold;" +
                "}" +

                "p {" +
                "color: #cbd5e1;" +
                "font-size: 17px;" +
                "}" +

                "</style>" +
                "</head>" +

                "<body>" +

                "<div class='container'>" +
                "<h1>SmartResume 🚀</h1>" +
                "<div class='success'>" +
                "Database Connected Successfully!" +
                "</div>" +

                "<p>Java → JDBC → MySQL is working perfectly.</p>" +
                "<p>Backend foundation is ready.</p>" +

                "</div>" +

                "</body>" +
                "</html>"
            );

        } catch (SQLException e) {

            response.setStatus(
                HttpServletResponse.SC_INTERNAL_SERVER_ERROR
            );

            response.getWriter().println(
                "<!DOCTYPE html>" +
                "<html>" +
                "<head>" +
                "<meta charset='UTF-8'>" +
                "<title>Database Error</title>" +
                "</head>" +

                "<body>" +

                "<h1>Database Connection Failed ❌</h1>" +

                "<p>Could not connect to MySQL.</p>" +

                "<pre>" +
                e.getMessage() +
                "</pre>" +

                "</body>" +
                "</html>"
            );
        }
    }
}