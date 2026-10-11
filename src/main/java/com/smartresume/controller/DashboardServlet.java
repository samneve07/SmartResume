package com.smartresume.controller;

import java.io.IOException;
import java.util.List;

import com.smartresume.dao.ResumeDAO;
import com.smartresume.dao.ResumeDAO.ResumeData;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ResumeDAO resumeDAO = new ResumeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Object id = session.getAttribute("userId");
        int userId;
        try {
            userId = Integer.parseInt(String.valueOf(id));
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<ResumeData> resumes = resumeDAO.getResumesByUserId(userId);
        request.setAttribute("resumeCount", resumes.size());
        request.setAttribute("resumes", resumes);
        request.getRequestDispatcher("/WEB-INF/views/dashboard/dashboard.jsp")
               .forward(request, response);
    }
}