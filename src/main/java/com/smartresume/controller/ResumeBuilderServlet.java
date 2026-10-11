package com.smartresume.controller;

import java.io.IOException;
import java.util.Base64;

import com.smartresume.dao.ResumeDAO;
import com.smartresume.dao.ResumeDAO.ResumeData;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/resume-builder")
@MultipartConfig(
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
public class ResumeBuilderServlet extends HttpServlet {

    private final ResumeDAO resumeDAO = new ResumeDAO();

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
                (Integer) session.getAttribute(
                        "userId"
                );

        String requestedTemplate =
                request.getParameter(
                        "template"
                );

        String selectedTemplate =
                normalizeTemplate(
                        requestedTemplate
                );

        String resumeIdParam =
                request.getParameter(
                        "resumeId"
                );

        ResumeData resumeData = null;

        if (resumeIdParam != null &&
                !resumeIdParam.isBlank()) {

            try {

                int resumeId =
                        Integer.parseInt(
                                resumeIdParam
                        );

                resumeData =
                        resumeDAO.getResumeById(
                                resumeId,
                                userId
                        );

            } catch (NumberFormatException ignored) {
                // Create mode.
            }
        }

        if (resumeData != null) {

            if (requestedTemplate == null ||
                    requestedTemplate.isBlank()) {

                selectedTemplate =
                        normalizeTemplate(
                                resumeData.getTemplate()
                        );
            }

            request.setAttribute(
                    "resumeData",
                    resumeData
            );
        }

        if (selectedTemplate == null) {

            Object sessionTemplate =
                    session.getAttribute(
                            "selectedTemplate"
                    );

            selectedTemplate =
                    normalizeTemplate(
                            sessionTemplate == null
                                    ? null
                                    : sessionTemplate.toString()
                    );
        }

        if (selectedTemplate == null) {
            selectedTemplate = "template-01";
        }

        session.setAttribute(
                "selectedTemplate",
                selectedTemplate
        );

        request.setAttribute(
                "selectedTemplate",
                selectedTemplate
        );

        request.setAttribute(
                "saved",
                "true".equals(
                        request.getParameter(
                                "saved"
                        )
                )
        );

        request.getRequestDispatcher(
                "/WEB-INF/views/resume-builder.jsp"
        ).forward(
                request,
                response
        );
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendError(
                    HttpServletResponse.SC_UNAUTHORIZED
            );

            return;
        }

        int userId =
                (Integer) session.getAttribute(
                        "userId"
                );

        String resumeTitle =
                value(
                        request,
                        "resumeTitle",
                        "My Resume"
                );

        String fullName =
                value(request, "fullName", "");

        String email =
                value(request, "email", "");

        String phone =
                value(request, "phone", "");

        String location =
                value(request, "location", "");

        String linkedin =
                value(request, "linkedin", "");

        String github =
                value(request, "github", "");

        String summary =
                value(request, "summary", "");

        String education =
                value(request, "education", "");

        String skills =
                value(request, "skills", "");

        String projects =
                value(request, "projects", "");

        String experience =
                value(request, "experience", "");

        String certifications =
                value(request, "certifications", "");

        String languages =
                value(request, "languages", "");

        String achievements =
                value(request, "achievements", "");

        String interests =
                value(request, "interests", "");

        String template =
                normalizeTemplate(
                        request.getParameter(
                                "template"
                        )
                );

        if (template == null) {
            template = "template-01";
        }

        String themeColor =
                value(
                        request,
                        "themeColor",
                        "#111111"
                );

        String profilePhoto =
                value(
                        request,
                        "existingProfilePhoto",
                        ""
                );

        Part photoPart = null;

        try {

            photoPart =
                    request.getPart(
                            "profilePhoto"
                    );

        } catch (Exception ignored) {
            // No upload.
        }

        if (photoPart != null &&
                photoPart.getSize() > 0) {

            String contentType =
                    photoPart.getContentType();

            if (contentType == null ||
                    !contentType
                            .toLowerCase()
                            .startsWith("image/")) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Only image files are allowed."
                );

                return;
            }

            byte[] bytes =
                    photoPart
                            .getInputStream()
                            .readAllBytes();

            profilePhoto =
                    "data:" +
                    contentType +
                    ";base64," +
                    Base64.getEncoder()
                            .encodeToString(
                                    bytes
                            );
        }

        session.setAttribute(
                "selectedTemplate",
                template
        );

        String resumeIdParam =
                request.getParameter(
                        "resumeId"
                );

        if (resumeIdParam != null &&
                !resumeIdParam.isBlank()) {

            try {

                int resumeId =
                        Integer.parseInt(
                                resumeIdParam
                        );

                ResumeData existing =
                        resumeDAO.getResumeById(
                                resumeId,
                                userId
                        );

                if (existing == null) {

                    response.sendError(
                            HttpServletResponse.SC_NOT_FOUND,
                            "Resume not found."
                    );

                    return;
                }

                if (profilePhoto.isBlank()) {

                    profilePhoto =
                            existing.getProfilePhoto();
                }

                resumeDAO.updateResume(
                        resumeId,
                        userId,
                        resumeTitle,
                        fullName,
                        email,
                        phone,
                        location,
                        linkedin,
                        github,
                        summary,
                        education,
                        skills,
                        projects,
                        experience,
                        certifications,
                        languages,
                        achievements,
                        interests,
                        profilePhoto,
                        template,
                        themeColor
                );

                response.sendRedirect(
                        request.getContextPath() +
                        "/resume-builder?resumeId=" +
                        resumeId +
                        "&saved=true"
                );

                return;

            } catch (NumberFormatException e) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid resume ID."
                );

                return;
            }
        }

        int resumeId =
                resumeDAO.createResume(
                        userId,
                        resumeTitle,
                        fullName,
                        email,
                        phone,
                        location,
                        linkedin,
                        github,
                        summary,
                        education,
                        skills,
                        projects,
                        experience,
                        certifications,
                        languages,
                        achievements,
                        interests,
                        profilePhoto,
                        template,
                        themeColor
                );

        if (resumeId <= 0) {

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Could not save resume."
            );

            return;
        }

        response.sendRedirect(
                request.getContextPath() +
                "/resume-builder?resumeId=" +
                resumeId +
                "&saved=true"
        );
    }

    private String value(
            HttpServletRequest request,
            String parameter,
            String fallback) {

        String value =
                request.getParameter(
                        parameter
                );

        if (value == null) {
            return fallback;
        }

        return value.trim();
    }

    private String normalizeTemplate(
            String template) {

        if (template == null ||
                template.isBlank()) {

            return null;
        }

        String value =
                template.trim()
                        .toLowerCase();

        
switch (value) {
    case "template-01":
    case "template-02":
    case "template-03":
    case "template-04":
    case "template-05":
    case "template-06":
    case "template-07":
    case "template-08":
    case "template-09":
    case "template-10":
    case "template-11":
    case "template-12":
        return value;

    default:
        return null;
}
    }
}

