package com.smartresume.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/templates")
public class TemplateGalleryServlet extends HttpServlet {

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


        String template =
                request.getParameter("template");


        /*
         * If a user clicks "Use Template",
         * send that selected template to the
         * Resume Builder.
         */
        if (template != null &&
                !template.isBlank()) {

            String selectedTemplate =
                    template.trim().toLowerCase();


            if (isValidTemplate(selectedTemplate)) {

                response.sendRedirect(
                        request.getContextPath() +
                        "/resume-builder?template=" +
                        selectedTemplate
                );

                return;
            }
        }


        request.getRequestDispatcher(
                "/WEB-INF/views/templates.jsp"
        ).forward(
                request,
                response
        );
    }


    private boolean isValidTemplate(String template) {
        return template != null && template.matches("template-(0[1-9]|1[0-2])");
    }
}
