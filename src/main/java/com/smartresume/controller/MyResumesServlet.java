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

@WebServlet("/my-resumes")
public class MyResumesServlet extends HttpServlet {

    private final ResumeDAO resumeDAO =
            new ResumeDAO();


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);


        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/login"
            );

            return;
        }


        int userId =
                getUserId(session);


        List<ResumeData> resumes =
                resumeDAO.getResumesByUserId(
                        userId
                );


        request.setAttribute(
                "resumes",
                resumes
        );


        request.getRequestDispatcher(
                "/WEB-INF/views/resume/my-resumes.jsp"
        ).forward(
                request,
                response
        );
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session =
                request.getSession(false);


        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/login"
            );

            return;
        }


        int userId =
                getUserId(session);


        int resumeId =
                parseInt(
                        request.getParameter("resumeId"),
                        0
                );


        String action =
                request.getParameter(
                        "action"
                );


        if (resumeId <= 0) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/my-resumes"
            );

            return;
        }


        if ("delete".equals(action)) {

            resumeDAO.deleteResume(
                    resumeId,
                    userId
            );

        } else if ("duplicate".equals(action)) {

            resumeDAO.duplicateResume(
                    resumeId,
                    userId
            );
        }


        response.sendRedirect(
                request.getContextPath() +
                "/my-resumes"
        );
    }


    private int getUserId(
            HttpSession session) {

        Object value =
                session.getAttribute(
                        "userId"
                );


        if (value instanceof Number) {

            return ((Number) value)
                    .intValue();
        }


        return parseInt(
                String.valueOf(value),
                0
        );
    }


    private int parseInt(
            String value,
            int fallback) {

        try {

            return Integer.parseInt(value);

        } catch (Exception e) {

            return fallback;
        }
    }
}