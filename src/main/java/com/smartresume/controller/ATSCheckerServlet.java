
package com.smartresume.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.pdfbox.Loader;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.apache.poi.xwpf.usermodel.XWPFDocument;

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

@WebServlet("/ats")
@MultipartConfig(
    maxFileSize = 10 * 1024 * 1024,
    maxRequestSize = 12 * 1024 * 1024
)
public class ATSCheckerServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ResumeDAO resumeDAO = new ResumeDAO();

    private static final Set<String> TECH_SKILLS = Set.of(
        "java", "python", "javascript", "typescript", "c++", "c#",
        "sql", "mysql", "postgresql", "mongodb", "oracle",
        "html", "css", "react", "angular", "node.js", "spring",
        "spring boot", "servlets", "jsp", "jdbc", "hibernate",
        "rest api", "api development", "git", "github",
        "docker", "kubernetes", "aws", "azure", "gcp",
        "linux", "devops", "ci/cd", "machine learning",
        "deep learning", "artificial intelligence", "data science",
        "data analysis", "data visualization", "power bi", "tableau",
        "excel", "statistics", "pandas", "numpy",
        "software testing", "selenium", "automation testing",
        "cybersecurity", "network security", "agile", "scrum",
        "data structures", "algorithms", "object oriented programming",
        "oop", "problem solving", "communication",
        "project management", "business analysis",
        "financial analysis", "digital marketing", "seo",
        "recruitment", "talent acquisition", "accounting"
    );

    private static final Set<String> STOP_WORDS = Set.of(
        "a", "an", "and", "are", "as", "at", "be", "been", "being",
        "by", "for", "from", "has", "have", "had", "he", "her",
        "his", "i", "in", "into", "is", "it", "its", "me", "my",
        "of", "on", "or", "our", "she", "that", "the", "their",
        "them", "there", "these", "they", "this", "those", "to",
        "us", "was", "we", "were", "will", "with", "you", "your",
        "who", "what", "when", "where", "why", "how", "can",
        "could", "should", "would", "must", "may", "might",
        "company", "department", "location", "position", "job",
        "role", "candidate", "candidates", "looking", "seeking",
        "join", "team", "teams", "opportunity", "opportunities",
        "work", "working", "responsibility", "responsibilities",
        "requirement", "requirements", "preferred", "required",
        "qualification", "qualifications", "description",
        "description:", "about", "including", "etc", "good",
        "great", "strong", "excellent", "motivated", "passionate",
        "dynamic", "professional", "environment", "world",
        "solutions", "technology", "technologies", "information",
        "mumbai", "maharashtra", "india", "graduate", "fresher",
        "full", "time", "entry", "level", "years", "year",
        "months", "month", "salary", "benefits", "apply",
        "application", "applications", "new", "ability"
    );

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        request.setAttribute(
            "resumes",
            resumeDAO.getResumesByUserId(userId)
        );

        request.getRequestDispatcher(
            "/WEB-INF/views/ats/ats-checker.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        request.setAttribute(
            "resumes",
            resumeDAO.getResumesByUserId(userId)
        );

        String resumeIdText = safe(request.getParameter("resumeId"));
        String jobDescription =
            safe(request.getParameter("jobDescription")).trim();

        request.setAttribute("selectedResumeId", resumeIdText);
        request.setAttribute("jobDescription", jobDescription);

        String resumeText = "";
        ResumeData savedResume = null;
        String sourceName = "";

        try {
            Part filePart = request.getPart("resumeFile");

            if (filePart != null
                    && filePart.getSize() > 0
                    && filePart.getSubmittedFileName() != null
                    && !filePart.getSubmittedFileName().isBlank()) {

                String fileName = filePart.getSubmittedFileName()
                    .replace("\\", "/");

                fileName = fileName.substring(
                    fileName.lastIndexOf('/') + 1
                );

                String lowerName = fileName.toLowerCase(Locale.ROOT);

                if (lowerName.endsWith(".pdf")) {
                    try (InputStream input = filePart.getInputStream();
                         PDDocument document =
                             Loader.loadPDF(input.readAllBytes())) {

                        resumeText = new PDFTextStripper()
                            .getText(document);
                    }

                } else if (lowerName.endsWith(".docx")) {
                    try (InputStream input = filePart.getInputStream();
                         XWPFDocument document = new XWPFDocument(input)) {

                        StringBuilder extracted = new StringBuilder();

                        document.getParagraphs().forEach(paragraph ->
                            extracted.append(paragraph.getText()).append(" ")
                        );

                        document.getTables().forEach(table ->
                            table.getRows().forEach(row ->
                                row.getTableCells().forEach(cell ->
                                    extracted.append(cell.getText()).append(" ")
                                )
                            )
                        );

                        resumeText = extracted.toString();

                    }
                } else {
                    request.setAttribute(
                        "errorMessage",
                        "Please upload a valid PDF or DOCX file."
                    );
                    forwardToATS(request, response);
                    return;
                }

                sourceName = fileName;

                if (resumeText.isBlank()) {
                    request.setAttribute(
                        "errorMessage",
                        "No readable text was found. Scanned PDFs may require OCR."
                    );
                    forwardToATS(request, response);
                    return;
                }

            } else if (!resumeIdText.isBlank()) {

                try {
                    int resumeId = Integer.parseInt(resumeIdText);
                    savedResume =
                        resumeDAO.getResumeById(resumeId, userId);
                } catch (NumberFormatException ignored) {
                    savedResume = null;
                }

                if (savedResume == null) {
                    request.setAttribute(
                        "errorMessage",
                        "Please select a valid saved resume or upload a file."
                    );
                    forwardToATS(request, response);
                    return;
                }

                resumeText = String.join(" ",
                    safe(savedResume.getResumeTitle()),
                    safe(savedResume.getFullName()),
                    safe(savedResume.getEmail()),
                    safe(savedResume.getPhone()),
                    safe(savedResume.getLocation()),
                    safe(savedResume.getLinkedin()),
                    safe(savedResume.getGithub()),
                    safe(savedResume.getSummary()),
                    safe(savedResume.getEducation()),
                    safe(savedResume.getSkills()),
                    safe(savedResume.getProjects()),
                    safe(savedResume.getExperience()),
                    safe(savedResume.getCertifications()),
                    safe(savedResume.getLanguages()),
                    safe(savedResume.getAchievements()),
                    safe(savedResume.getInterests())
                );

                sourceName = safe(savedResume.getResumeTitle());

            } else {
                request.setAttribute(
                    "errorMessage",
                    "Choose a saved resume or upload a PDF/DOCX file."
                );
                forwardToATS(request, response);
                return;
            }

        } catch (IllegalStateException e) {
            request.setAttribute(
                "errorMessage",
                "File too large. Maximum upload size is 10 MB."
            );
            forwardToATS(request, response);
            return;

        } catch (Exception e) {
            getServletContext().log("ATS resume extraction failed", e);

            request.setAttribute(
                "errorMessage",
                "Could not read this file. Please check that it is a valid PDF or DOCX."
            );
            forwardToATS(request, response);
            return;
        }

        request.setAttribute("sourceName", sourceName);

        if (jobDescription.isBlank()) {
            request.setAttribute(
                "errorMessage",
                "Paste the job description before analyzing."
            );
            forwardToATS(request, response);
            return;
        }

        String normalizedJD = normalize(jobDescription);
        String normalizedResume = normalize(resumeText);

        Map<String, Integer> requirements =
            extractRelevantRequirements(normalizedJD);

        if (requirements.size() < 3) {
            request.setAttribute(
                "errorMessage",
                "Not enough relevant skills or qualifications were detected. Paste a fuller job description with specific requirements."
            );
            forwardToATS(request, response);
            return;
        }

        int totalWeight = 0;
        int matchedWeight = 0;

        List<String> matched = new ArrayList<>();
        List<String> missing = new ArrayList<>();

        for (Map.Entry<String, Integer> entry : requirements.entrySet()) {
            String requirement = entry.getKey();
            int weight = entry.getValue();

            totalWeight += weight;

            if (containsKeyword(normalizedResume, requirement)) {
                matched.add(requirement);
                matchedWeight += weight;
            } else {
                missing.add(requirement);
            }
        }

        int score = totalWeight == 0 ? 0
            : (int) Math.round(matchedWeight * 100.0 / totalWeight);

        request.setAttribute("score", score);
        request.setAttribute("matchedKeywords", matched);
        request.setAttribute("missingKeywords", missing);
        request.setAttribute("analyzed", Boolean.TRUE);

        request.setAttribute(
            "careerRoles",
            suggestCareerRoles(normalizedResume)
        );

        List<String> tips = new ArrayList<>();

        if (score < 40) {
            tips.add(
                "Your resume currently shows limited overlap with this job description. Review the role's core skills and your relevant projects."
            );
        } else if (score < 70) {
            tips.add(
                "Your resume has some relevant overlap. Improve the evidence for missing high-priority requirements where truthful."
            );
        } else {
            tips.add(
                "Your resume shows strong keyword overlap. Check that the skills are demonstrated through projects or experience."
            );
        }

        if (missing.size() > 0) {
            tips.add(
                "Missing requirements are listed above. Add them only if you genuinely possess those skills or qualifications."
            );
        }

        if (savedResume != null) {
            if (safe(savedResume.getSummary()).isBlank()) {
                tips.add(
                    "Add a concise professional summary tailored to the target role."
                );
            }
            if (safe(savedResume.getProjects()).isBlank()) {
                tips.add(
                    "Add relevant projects and describe your personal contribution."
                );
            }
            if (safe(savedResume.getEducation()).isBlank()) {
                tips.add(
                    "Complete your education section."
                );
            }
        }

        request.setAttribute("tips", tips);

        forwardToATS(request, response);
    }

    private void forwardToATS(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
            "/WEB-INF/views/ats/ats-checker.jsp"
        ).forward(request, response);
    }

    private String safe(String value) {
        return value == null ? "" : value;
    }

    private String normalize(String text) {
        return safe(text)
            .toLowerCase(Locale.ROOT)
            .replaceAll("[^a-z0-9+#./ ]", " ")
            .replaceAll("\\s+", " ")
            .trim();
    }

    private boolean containsKeyword(String text, String keyword) {
        if (keyword.contains(" ")) {
            return text.contains(keyword);
        }

        Pattern pattern = Pattern.compile(
            "(?<![a-z0-9])" + Pattern.quote(keyword) + "(?![a-z0-9])"
        );

        return pattern.matcher(text).find();
    }

    /*
     * Extract only role-relevant requirements.
     * Technical skills receive weight 3.
     * Education/experience requirements receive weight 2.
     * Generic words and location/company details are excluded.
     */
    private Map<String, Integer> extractRelevantRequirements(String jd) {

        Map<String, Integer> requirements = new LinkedHashMap<>();

        for (String skill : TECH_SKILLS) {
            if (containsKeyword(jd, skill)) {
                requirements.put(skill, 3);
            }
        }

        String[] qualificationPhrases = {
            "bachelor degree",
            "bachelor's degree",
            "bachelor of engineering",
            "bachelor of technology",
            "master degree",
            "master's degree",
            "computer science",
            "information technology",
            "relevant degree",
            "internship experience",
            "professional experience",
            "software development",
            "web development",
            "database management",
            "object oriented programming",
            "problem solving",
            "communication skills",
            "analytical skills",
            "teamwork",
            "leadership",
            "project management",
            "business analysis"
        };

        for (String phrase : qualificationPhrases) {
            if (containsKeyword(jd, phrase)) {
                requirements.putIfAbsent(phrase, 2);
            }
        }

        /*
         * Add useful technical tokens only when they are not generic
         * words and are not already covered by a known skill phrase.
         */
        Matcher matcher = Pattern
            .compile("[a-z][a-z0-9+#.]{1,}")
            .matcher(jd);

        while (matcher.find()) {
            String word = matcher.group().replaceAll("\\.$", "");

            if (word.length() < 2 || STOP_WORDS.contains(word)) {
                continue;
            }

            boolean alreadyCovered = false;

            for (String existing : requirements.keySet()) {
                if (existing.equals(word) || existing.contains(word)) {
                    alreadyCovered = true;
                    break;
                }
            }

            if (!alreadyCovered && looksLikeTechnicalTerm(word)) {
                requirements.put(word, 1);
            }

            if (requirements.size() >= 50) {
                break;
            }
        }

        return requirements;
    }

    private boolean looksLikeTechnicalTerm(String word) {
        return word.matches(".*\\d.*")
            || word.contains("+")
            || word.contains("#")
            || word.contains(".")
            || word.length() >= 3;
    }

    private List<String> suggestCareerRoles(String resumeText) {

        List<String> roles = new ArrayList<>();

        addRoleIfRelevant(
            roles, resumeText, "Java Developer",
            List.of("java", "spring", "spring boot", "jdbc", "servlets")
        );

        addRoleIfRelevant(
            roles, resumeText, "Software Developer",
            List.of("programming", "algorithms", "java", "python",
                    "c++", "software development")
        );

        addRoleIfRelevant(
            roles, resumeText, "Web Developer",
            List.of("html", "css", "javascript", "react",
                    "frontend", "backend", "web development")
        );

        addRoleIfRelevant(
            roles, resumeText, "Data Analyst",
            List.of("sql", "excel", "power bi", "tableau",
                    "python", "data analysis", "statistics")
        );

        addRoleIfRelevant(
            roles, resumeText, "QA / Software Test Engineer",
            List.of("testing", "selenium", "automation testing",
                    "test cases", "quality assurance", "jira")
        );

        addRoleIfRelevant(
            roles, resumeText, "Data Scientist",
            List.of("machine learning", "statistics", "pandas",
                    "numpy", "python", "data science")
        );

        addRoleIfRelevant(
            roles, resumeText, "Cybersecurity Analyst",
            List.of("cybersecurity", "network security",
                    "penetration testing", "linux", "security")
        );

        addRoleIfRelevant(
            roles, resumeText, "Cloud / DevOps Associate",
            List.of("aws", "azure", "docker", "kubernetes",
                    "linux", "cloud", "devops")
        );

        addRoleIfRelevant(
            roles, resumeText, "Digital Marketing Associate",
            List.of("digital marketing", "seo", "sem",
                    "social media", "google analytics")
        );

        addRoleIfRelevant(
            roles, resumeText, "HR / Talent Acquisition Associate",
            List.of("recruitment", "talent acquisition",
                    "human resources", "employee engagement")
        );

        addRoleIfRelevant(
            roles, resumeText, "Finance Analyst",
            List.of("financial analysis", "accounting",
                    "financial modeling", "excel", "finance")
        );

        addRoleIfRelevant(
            roles, resumeText, "Business Analyst",
            List.of("business analysis", "requirements",
                    "stakeholders", "sql", "process improvement", "excel")
        );

        if (roles.isEmpty()) {
            roles.add(
                "Not enough role-specific skills detected yet. Add relevant skills, projects, education and experience."
            );
        }

        return roles;
    }

    private void addRoleIfRelevant(
            List<String> roles,
            String resumeText,
            String role,
            List<String> relevantSkills) {

        int matches = 0;

        for (String skill : relevantSkills) {
            if (containsKeyword(resumeText, skill)) {
                matches++;
            }
        }

        if (matches >= 2) {
            roles.add(
                role + " — " + matches + " relevant skill indicators found"
            );
        }
    }
}