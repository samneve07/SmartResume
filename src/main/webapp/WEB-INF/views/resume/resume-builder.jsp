<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%!
    private String escHtml(String value) {
        if (value == null) return "";
        return value
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#039;");
    }
%>

<%
    String contextPath = request.getContextPath();

    String sessionFullName = (String) session.getAttribute("fullName");
    String sessionEmail = (String) session.getAttribute("email");

    if (sessionFullName == null) sessionFullName = "";
    if (sessionEmail == null) sessionEmail = "";

    com.smartresume.dao.ResumeDAO.ResumeData savedResume =
            (com.smartresume.dao.ResumeDAO.ResumeData) request.getAttribute("resume");

    int loadedResumeId = savedResume != null ? savedResume.getResumeId() : 0;

    String fullName = savedResume != null && savedResume.getFullName() != null
            ? savedResume.getFullName() : sessionFullName;
    String email = savedResume != null && savedResume.getEmail() != null
            ? savedResume.getEmail() : sessionEmail;
    String phone = savedResume != null ? savedResume.getPhone() : "";
    String location = savedResume != null ? savedResume.getLocation() : "";
    String linkedin = savedResume != null ? savedResume.getLinkedin() : "";
    String github = savedResume != null ? savedResume.getGithub() : "";
    String summary = savedResume != null ? savedResume.getSummary() : "";
    String education = savedResume != null ? savedResume.getEducation() : "";
    String skills = savedResume != null ? savedResume.getSkills() : "";
    String projects = savedResume != null ? savedResume.getProjects() : "";
    String experience = savedResume != null ? savedResume.getExperience() : "";
    String certifications = savedResume != null ? savedResume.getCertifications() : "";
    String languages = savedResume != null ? savedResume.getLanguages() : "";
    String achievements = savedResume != null ? savedResume.getAchievements() : "";
    String interests = savedResume != null ? savedResume.getInterests() : "";
    String profilePhoto = savedResume != null ? savedResume.getProfilePhoto() : "";
    String loadedTemplate = savedResume != null && savedResume.getTemplate() != null
            ? savedResume.getTemplate() : "modern";
    String loadedThemeColor = savedResume != null && savedResume.getThemeColor() != null
            ? savedResume.getThemeColor() : "#111111";
    String loadedTitle = savedResume != null && savedResume.getResumeTitle() != null
            ? savedResume.getResumeTitle() : "My Resume";

    String avatarLetter = fullName.isEmpty()
            ? "S"
            : fullName.substring(0, 1).toUpperCase();
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>SmartResume — Resume Builder</title>

<style>

/* =========================================================
   RESET
========================================================= */

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

:root {
    --black: #111111;
    --dark: #181818;
    --lime: #c8ff32;

    --bg: #efefec;
    --panel: #ffffff;
    --soft: #f7f7f4;

    --line: #e4e4df;

    --text: #181818;
    --muted: #888888;

    --accent: #111111;
}

html,
body {
    width: 100%;
    height: 100%;
}

body {
    font-family:
        Inter,
        ui-sans-serif,
        -apple-system,
        BlinkMacSystemFont,
        "Segoe UI",
        sans-serif;

    background: var(--bg);
    color: var(--text);

    overflow: hidden;
}

button,
input,
textarea,
select {
    font: inherit;
}

button {
    cursor: pointer;
}

a {
    text-decoration: none;
    color: inherit;
}

/* =========================================================
   APP
========================================================= */

.builder-app {
    width: 100vw;
    height: 100vh;

    display: flex;
    flex-direction: column;
}

/* =========================================================
   TOP BAR
========================================================= */

.topbar {
    height: 68px;

    flex-shrink: 0;

    background: #fff;

    border-bottom: 1px solid var(--line);

    display: flex;
    align-items: center;

    padding: 0 18px;

    z-index: 100;
}

.top-left {
    width: 285px;

    display: flex;
    align-items: center;

    gap: 12px;
}

.back-button {
    width: 36px;
    height: 36px;

    border: 1px solid var(--line);

    background: #fff;

    border-radius: 9px;

    display: flex;
    align-items: center;
    justify-content: center;

    font-size: 17px;

    transition: .2s;
}

.back-button:hover {
    background: #f2f2ef;
}

.logo-mini {
    width: 35px;
    height: 35px;

    border-radius: 10px;

    background: #111;

    color: var(--lime);

    display: flex;
    align-items: center;
    justify-content: center;

    font-weight: 900;
}

.project-name {
    min-width: 0;
}

.project-name input {
    width: 155px;

    border: none;

    outline: none;

    background: transparent;

    font-size: 13px;

    font-weight: 800;
}

.project-status {
    display: flex;
    align-items: center;

    gap: 5px;

    margin-top: 2px;

    font-size: 9px;

    color: #999;
}

.status-dot {
    width: 6px;
    height: 6px;

    border-radius: 50%;

    background: #78c800;
}

/* =========================================================
   TOP CENTER
========================================================= */

.top-center {
    flex: 1;

    display: flex;
    align-items: center;
    justify-content: center;

    gap: 4px;
}

.top-tab {
    height: 38px;

    padding: 0 16px;

    border: none;

    border-radius: 9px;

    background: transparent;

    color: #999;

    font-size: 11px;

    font-weight: 800;
}

.top-tab:hover {
    background: #f4f4f1;
}

.top-tab.active {
    background: #111;

    color: #fff;
}

/* =========================================================
   TOP RIGHT
========================================================= */

.top-right {
    width: 285px;

    display: flex;
    align-items: center;
    justify-content: flex-end;

    gap: 7px;
}

.top-button {
    height: 36px;

    padding: 0 12px;

    border-radius: 8px;

    border: 1px solid var(--line);

    background: #fff;

    font-size: 10px;

    font-weight: 800;

    display: flex;
    align-items: center;
    justify-content: center;

    gap: 5px;

    transition: .2s;
}

.top-button:hover {
    border-color: #aaa;
}

.top-button.dark {
    background: #111;

    color: #fff;

    border-color: #111;
}

.top-button.dark:hover {
    background: #292929;
}

.user-avatar {
    width: 35px;
    height: 35px;

    border-radius: 9px;

    background: var(--lime);

    display: flex;
    align-items: center;
    justify-content: center;

    font-size: 11px;

    font-weight: 900;
}

/* =========================================================
   MAIN WORKSPACE
========================================================= */

.workspace {
    flex: 1;

    min-height: 0;

    display: grid;

    grid-template-columns:
        285px
        minmax(410px, 1fr)
        minmax(480px, 1.1fr);

    overflow: hidden;
}

/* =========================================================
   LEFT PANEL
========================================================= */

.editor-panel {
    background: #fff;

    border-right: 1px solid var(--line);

    min-width: 0;

    display: flex;
    flex-direction: column;
}

.editor-tabs {
    height: 55px;

    flex-shrink: 0;

    border-bottom: 1px solid var(--line);

    padding: 0 12px;

    display: flex;
    align-items: center;

    gap: 4px;
}

.editor-tab {
    flex: 1;

    height: 35px;

    border: none;

    background: transparent;

    border-radius: 8px;

    color: #999;

    font-size: 9px;

    font-weight: 900;
}

.editor-tab.active {
    background: #111;

    color: #fff;
}

.editor-scroll {
    flex: 1;

    overflow-y: auto;

    padding: 18px;
}

.editor-scroll::-webkit-scrollbar {
    width: 5px;
}

.editor-scroll::-webkit-scrollbar-thumb {
    background: #d2d2cd;

    border-radius: 10px;
}

/* =========================================================
   FORM SECTIONS
========================================================= */

.section-block {
    margin-bottom: 25px;
}

.section-heading {
    display: flex;

    align-items: center;
    justify-content: space-between;

    margin-bottom: 12px;
}

.section-heading-left {
    display: flex;

    align-items: center;

    gap: 8px;
}

.section-heading-icon {
    width: 27px;
    height: 27px;

    border-radius: 7px;

    background: #f0f0ed;

    display: flex;

    align-items: center;
    justify-content: center;

    font-size: 12px;
}

.section-heading h3 {
    font-size: 12px;

    font-weight: 850;
}

.section-heading p {
    margin-top: 2px;

    color: #aaa;

    font-size: 8px;
}

.collapse {
    border: none;

    background: transparent;

    color: #aaa;
}

/* =========================================================
   FIELDS
========================================================= */

.field {
    margin-bottom: 10px;
}

.field label {
    display: block;

    margin-bottom: 5px;

    color: #777;

    font-size: 8px;

    font-weight: 850;

    letter-spacing: .3px;
}

.field input,
.field textarea,
.field select {
    width: 100%;

    border: 1px solid #dfdfdb;

    background: #fafaf8;

    border-radius: 8px;

    padding: 10px 11px;

    outline: none;

    color: #222;

    font-size: 10px;

    transition: .2s;
}

.field input:focus,
.field textarea:focus,
.field select:focus {
    background: #fff;

    border-color: #aaa;

    box-shadow:
        0 0 0 3px rgba(200,255,50,.12);
}

.field textarea {
    min-height: 82px;

    resize: vertical;

    line-height: 1.5;
}

.two-fields {
    display: grid;

    grid-template-columns: 1fr 1fr;

    gap: 8px;
}

/* =========================================================
   ENTRY CARD
========================================================= */

.entry-card {
    background: #fafaf8;

    border: 1px solid #e5e5e1;

    border-radius: 10px;

    padding: 11px;

    margin-bottom: 9px;
}

.entry-card-head {
    display: flex;

    align-items: center;
    justify-content: space-between;

    margin-bottom: 9px;
}

.entry-card-title {
    font-size: 9px;

    font-weight: 900;
}

.remove-entry {
    width: 23px;
    height: 23px;

    border: none;

    background: #eeeeea;

    color: #888;

    border-radius: 6px;
}

.remove-entry:hover {
    color: #d22;
}

.add-button {
    width: 100%;

    height: 38px;

    border: 1px dashed #ccc;

    background: #fafaf8;

    border-radius: 9px;

    color: #555;

    font-size: 9px;

    font-weight: 850;
}

.add-button:hover {
    background: #f2f2ef;

    border-color: #999;

    color: #111;
}

/* =========================================================
   DESIGN PANEL
========================================================= */

.design-panel {
    display: none;
}

.design-panel.active {
    display: block;
}

.design-group {
    margin-bottom: 22px;

    padding-bottom: 20px;

    border-bottom: 1px solid #eee;
}

.design-group:last-child {
    border-bottom: none;
}

.design-label {
    margin-bottom: 10px;

    font-size: 9px;

    font-weight: 900;

    letter-spacing: .4px;
}

.template-mini-grid {
    display: grid;

    grid-template-columns: 1fr 1fr;

    gap: 8px;
}

.template-option {
    height: 105px;

    position: relative;

    overflow: hidden;

    border: 2px solid #e5e5e1;

    border-radius: 9px;

    background: #f7f7f4;

    padding: 7px;

    cursor: pointer;

    transition:
        transform .2s,
        border-color .2s,
        box-shadow .2s;
}

.template-option:hover {
    transform: translateY(-2px);

    border-color: #aaa;
}

.template-option.selected {
    border-color: #111;

    box-shadow:
        0 0 0 2px rgba(17,17,17,.08);
}

.template-option.selected::after {
    content: "✓";

    position: absolute;

    top: 6px;
    right: 6px;

    width: 18px;
    height: 18px;

    background: var(--lime);

    color: #111;

    border-radius: 50%;

    display: flex;
    align-items: center;
    justify-content: center;

    font-size: 9px;

    font-weight: 900;
}

.template-option::before {
    position: absolute;

    bottom: 5px;
    left: 7px;

    font-size: 6px;

    font-weight: 900;

    color: #999;
}

.template-option[data-template="modern"]::before {
    content: "MODERN";
}

.template-option[data-template="sidebar"]::before {
    content: "SIDEBAR";
}

.template-option[data-template="classic"]::before {
    content: "CLASSIC";
}

.template-option[data-template="minimal"]::before {
    content: "MINIMAL";
}

.template-option[data-template="executive"]::before {
    content: "EXECUTIVE";
}

.template-option[data-template="creative"]::before {
    content: "CREATIVE";
}

.template-option[data-template="developer"]::before {
    content: "DEVELOPER";
}

.template-option[data-template="corporate"]::before {
    content: "CORPORATE";
}

.mini-paper {
    width: 58px;
    height: 80px;

    margin: auto;

    padding: 7px;

    background: #fff;

    box-shadow:
        0 2px 9px rgba(0,0,0,.12);
}

.mini-paper .line {
    height: 3px;

    margin-bottom: 4px;

    background: #ddd;

    border-radius: 3px;
}

.mini-paper .line.dark {
    background: #222;
}

.mini-paper.sidebar-layout {
    display: grid;

    grid-template-columns: 17px 1fr;

    padding: 0;
}

.mini-paper.sidebar-layout .side {
    background: #111;
}

.mini-paper.sidebar-layout .mini-content {
    padding: 7px;
}

.color-row {
    display: flex;

    flex-wrap: wrap;

    gap: 9px;
}

.color-option {
    width: 28px;
    height: 28px;

    border-radius: 50%;

    border: 3px solid #fff;

    outline: 1px solid #ddd;

    cursor: pointer;
}

.color-option.selected {
    outline: 2px solid #111;
}

.color-black { background: #111; }
.color-blue { background: #2563eb; }
.color-green { background: #16a34a; }
.color-purple { background: #7c3aed; }
.color-red { background: #dc2626; }
.color-orange { background: #ea580c; }
.color-teal { background: #0f766e; }
.color-pink { background: #db2777; }

.range-row {
    display: flex;

    align-items: center;

    gap: 10px;
}

.range-row input {
    flex: 1;
}

.range-value {
    width: 35px;

    text-align: right;

    font-size: 9px;

    color: #777;
}

/* =========================================================
   SECTIONS PANEL
========================================================= */

.sections-panel {
    display: none;
}

.sections-panel.active {
    display: block;
}

.section-toggle-row {
    min-height: 43px;

    display: flex;

    align-items: center;
    justify-content: space-between;

    border-bottom: 1px solid #eee;
}

.section-toggle-info {
    display: flex;

    align-items: center;

    gap: 9px;
}

.drag {
    color: #bbb;
}

.toggle {
    width: 31px;
    height: 18px;

    border-radius: 20px;

    background: #ddd;

    position: relative;

    cursor: pointer;
}

.toggle::after {
    content: "";

    position: absolute;

    top: 2px;
    left: 2px;

    width: 14px;
    height: 14px;

    border-radius: 50%;

    background: #fff;

    box-shadow: 0 1px 3px rgba(0,0,0,.15);

    transition: .2s;
}

.toggle.on {
    background: #111;
}

.toggle.on::after {
    left: 15px;
}

/* =========================================================
   CENTER PANEL
========================================================= */

.center-panel {
    background: #eeeeeb;

    min-width: 0;

    display: flex;

    flex-direction: column;

    overflow: hidden;
}

.center-toolbar {
    height: 55px;

    flex-shrink: 0;

    background: rgba(255,255,255,.9);

    border-bottom: 1px solid var(--line);

    padding: 0 16px;

    display: flex;

    align-items: center;

    justify-content: space-between;
}

.toolbar-left,
.toolbar-right {
    display: flex;

    align-items: center;

    gap: 6px;
}

.tool-btn {
    width: 31px;
    height: 31px;

    border: 1px solid var(--line);

    background: #fff;

    border-radius: 7px;

    display: flex;

    align-items: center;
    justify-content: center;

    font-size: 12px;
}

.tool-btn:hover {
    border-color: #aaa;
}

.zoom {
    min-width: 40px;

    text-align: center;

    font-size: 9px;

    font-weight: 800;

    color: #777;
}

.canvas {
    flex: 1;

    overflow: auto;

    display: flex;

    justify-content: center;

    padding: 40px 30px 80px;
}

.canvas::-webkit-scrollbar,
.preview-body::-webkit-scrollbar {
    width: 7px;
}

.canvas::-webkit-scrollbar-thumb,
.preview-body::-webkit-scrollbar-thumb {
    background: #ccc;

    border-radius: 10px;
}

/* =========================================================
   A4 PAPER
========================================================= */

.paper-wrapper {
    flex-shrink: 0;

    transform-origin: top center;
}

.paper {
    width: 794px;

    min-height: 1123px;

    position: relative;

    background: #fff;

    color: #222;

    padding: 58px 62px;

    box-shadow:
        0 15px 40px rgba(0,0,0,.15);

    --accent: #111;
}

.paper-header {
    display: flex;

    align-items: flex-start;

    justify-content: space-between;

    padding-bottom: 22px;

    border-bottom: 2px solid var(--accent);
}

.paper-name {
    font-size: 35px;

    line-height: 1.05;

    font-weight: 800;

    letter-spacing: -1.5px;

    color: #111;
}

.paper-role {
    margin-top: 7px;

    color: #666;

    font-size: 10px;

    letter-spacing: 1.3px;

    text-transform: uppercase;
}

.paper-photo {
    width: 72px;
    height: 72px;

    flex-shrink: 0;

    border-radius: 50%;

    border: 2px solid #ddd;

    background: #eeeeeb;

    display: flex;

    align-items: center;
    justify-content: center;

    color: #aaa;

    font-size: 9px;

    overflow: hidden;
}

.paper-photo img {
    width: 100%;
    height: 100%;

    object-fit: cover;
}

.paper-contact {
    display: flex;

    flex-wrap: wrap;

    gap: 6px 14px;

    margin-top: 14px;

    color: #666;

    font-size: 8px;

    line-height: 1.5;
}

.paper-section {
    margin-top: 24px;
}

.paper-section-title {
    margin-bottom: 10px;

    color: var(--accent);

    font-size: 10px;

    font-weight: 900;

    letter-spacing: 1.5px;

    text-transform: uppercase;
}

.paper-summary {
    color: #555;

    font-size: 9px;

    line-height: 1.65;
}

.paper-entry {
    margin-bottom: 15px;
}

.paper-entry-head {
    display: flex;

    justify-content: space-between;

    gap: 15px;
}

.paper-entry-title {
    font-size: 10px;

    font-weight: 800;
}

.paper-entry-date {
    color: #777;

    font-size: 8px;

    white-space: nowrap;
}

.paper-entry-sub {
    margin-top: 3px;

    color: #666;

    font-size: 8px;
}

.paper-entry-description {
    margin-top: 5px;

    color: #555;

    font-size: 8px;

    line-height: 1.6;
}

.paper-skills {
    display: flex;

    flex-wrap: wrap;

    gap: 5px;
}

.paper-skill {
    padding: 5px 8px;

    background: #f0f0ed;

    border-radius: 4px;

    color: #444;

    font-size: 7px;
}

/* =========================================================
   RIGHT PREVIEW
========================================================= */

.preview-panel {
    background: #e7e7e3;

    border-left: 1px solid var(--line);

    min-width: 0;

    display: flex;

    flex-direction: column;

    overflow: hidden;
}

.preview-header {
    height: 55px;

    flex-shrink: 0;

    background: rgba(255,255,255,.9);

    border-bottom: 1px solid var(--line);

    padding: 0 18px;

    display: flex;

    align-items: center;

    justify-content: space-between;
}

.preview-title {
    font-size: 10px;

    font-weight: 900;
}

.preview-body {
    flex: 1;

    overflow: auto;

    display: flex;

    justify-content: center;

    padding: 35px 20px 80px;
}

.preview-paper {
    width: 794px;

    min-height: 1123px;

    flex-shrink: 0;

    position: relative;

    background: #fff;

    color: #222;

    padding: 58px 62px;

    box-shadow:
        0 15px 40px rgba(0,0,0,.14);

    transform-origin: top center;

    --accent: #111;
}

/* =========================================================
   REAL TEMPLATE STYLES
========================================================= */

/* MODERN */

.paper.template-modern,
.preview-paper.template-modern {
    font-family: Arial, sans-serif;
}

.paper.template-modern .paper-header,
.preview-paper.template-modern .paper-header {
    border-bottom: 2px solid var(--accent);
}

.paper.template-modern .paper-section-title,
.preview-paper.template-modern .paper-section-title {
    color: var(--accent);
}


/* SIDEBAR */

.paper.template-sidebar,
.preview-paper.template-sidebar {
    padding-left: 112px;
}

.paper.template-sidebar::before,
.preview-paper.template-sidebar::before {
    content: "";

    position: absolute;

    top: 0;
    bottom: 0;
    left: 0;

    width: 82px;

    background: #171717;
}

.paper.template-sidebar .paper-header,
.preview-paper.template-sidebar .paper-header {
    border-bottom: none;
}

.paper.template-sidebar .paper-name,
.preview-paper.template-sidebar .paper-name {
    color: var(--accent);
}


/* CLASSIC */

.paper.template-classic,
.preview-paper.template-classic {
    font-family: Georgia, "Times New Roman", serif;
}

.paper.template-classic .paper-header,
.preview-paper.template-classic .paper-header {
    border-bottom: 1px solid #222;
}

.paper.template-classic .paper-name,
.preview-paper.template-classic .paper-name {
    font-family: Georgia, serif;

    font-weight: 700;

    letter-spacing: -.5px;
}

.paper.template-classic .paper-section-title,
.preview-paper.template-classic .paper-section-title {
    color: #222;

    border-bottom: 1px solid var(--accent);

    padding-bottom: 5px;
}


/* MINIMAL */

.paper.template-minimal,
.preview-paper.template-minimal {
    font-family: Arial, sans-serif;

    padding: 72px;
}

.paper.template-minimal .paper-header,
.preview-paper.template-minimal .paper-header {
    border-bottom: none;
}

.paper.template-minimal .paper-name,
.preview-paper.template-minimal .paper-name {
    font-weight: 500;

    letter-spacing: -1px;
}

.paper.template-minimal .paper-section-title,
.preview-paper.template-minimal .paper-section-title {
    color: #222;

    font-size: 9px;

    letter-spacing: 2px;
}


/* EXECUTIVE */

.paper.template-executive,
.preview-paper.template-executive {
    font-family: Georgia, "Times New Roman", serif;

    padding: 55px 68px;
}

.paper.template-executive .paper-header,
.preview-paper.template-executive .paper-header {
    border-bottom: 1px solid #222;
}

.paper.template-executive .paper-name,
.preview-paper.template-executive .paper-name {
    font-family: Georgia, serif;

    font-size: 34px;

    font-weight: 700;
}

.paper.template-executive .paper-role,
.preview-paper.template-executive .paper-role {
    font-family: Georgia, serif;

    font-style: italic;
}

.paper.template-executive .paper-section-title,
.preview-paper.template-executive .paper-section-title {
    font-family: Georgia, serif;

    color: #222;

    border-bottom: 1px solid var(--accent);

    padding-bottom: 5px;
}


/* CREATIVE */

.paper.template-creative,
.preview-paper.template-creative {
    font-family: "Trebuchet MS", Arial, sans-serif;

    padding: 52px 60px;
}

.paper.template-creative .paper-header,
.preview-paper.template-creative .paper-header {
    border-bottom: none;
}

.paper.template-creative .paper-name,
.preview-paper.template-creative .paper-name {
    color: var(--accent);

    font-size: 40px;

    font-weight: 900;
}

.paper.template-creative .paper-section-title,
.preview-paper.template-creative .paper-section-title {
    color: var(--accent);

    border-left: 4px solid var(--accent);

    padding-left: 8px;
}


/* DEVELOPER */

.paper.template-developer,
.preview-paper.template-developer {
    font-family: "Courier New", monospace;

    padding: 48px 58px;
}

.paper.template-developer .paper-header,
.preview-paper.template-developer .paper-header {
    border-bottom: 2px dashed var(--accent);
}

.paper.template-developer .paper-name,
.preview-paper.template-developer .paper-name {
    font-family: "Courier New", monospace;

    font-size: 31px;

    font-weight: 700;
}

.paper.template-developer .paper-section-title,
.preview-paper.template-developer .paper-section-title {
    font-family: "Courier New", monospace;

    color: var(--accent);
}

.paper.template-developer .paper-skill,
.preview-paper.template-developer .paper-skill {
    font-family: "Courier New", monospace;

    border: 1px solid #ccc;

    background: #f3f3f3;
}


/* CORPORATE */

.paper.template-corporate,
.preview-paper.template-corporate {
    font-family: Arial, sans-serif;

    padding: 52px 60px;
}

.paper.template-corporate .paper-header,
.preview-paper.template-corporate .paper-header {
    background: var(--accent);

    padding: 25px;

    border-bottom: none;
}

.paper.template-corporate .paper-name,
.preview-paper.template-corporate .paper-name {
    color: #fff;

    font-size: 32px;
}

.paper.template-corporate .paper-role,
.preview-paper.template-corporate .paper-role {
    color: rgba(255,255,255,.8);
}

.paper.template-corporate .paper-section-title,
.preview-paper.template-corporate .paper-section-title {
    color: var(--accent);

    border-bottom: 1px solid #ddd;

    padding-bottom: 6px;
}


/* =========================================================
   MOBILE
========================================================= */

.mobile-editor {
    display: none;
}

@media (max-width: 1200px) {

    .workspace {
        grid-template-columns:
            275px
            minmax(390px, 1fr);
    }

    .preview-panel {
        display: none;
    }

    .top-left,
    .top-right {
        width: 275px;
    }

}

@media (max-width: 800px) {

    .workspace {
        grid-template-columns: 1fr;
    }

    .editor-panel {
        position: absolute;

        top: 68px;
        left: 0;
        bottom: 0;

        width: 300px;

        z-index: 500;

        transform: translateX(-100%);

        transition: transform .25s ease;
    }

    .editor-panel.open {
        transform: translateX(0);
    }

    .top-center {
        display: none;
    }

    .top-left {
        width: auto;

        flex: 1;
    }

    .top-right {
        width: auto;
    }

    .top-right .top-button:nth-child(1),
    .top-right .top-button:nth-child(2) {
        display: none;
    }

}


/* =========================================================
   PRINT
========================================================= */

@media print {

    body {
        overflow: visible !important;

        background: #fff !important;
    }

    .topbar,
    .editor-panel,
    .center-toolbar,
    .preview-panel {
        display: none !important;
    }

    .workspace {
        display: block !important;
    }

    .center-panel {
        display: block !important;

        overflow: visible !important;

        background: #fff !important;
    }

    .canvas {
        padding: 0 !important;

        overflow: visible !important;
    }

    .paper-wrapper {
        transform: none !important;
    }

    .paper {
        width: 210mm !important;

        min-height: 297mm !important;

        box-shadow: none !important;

        margin: 0 !important;
    }

    @page {
        size: A4;

        margin: 0;
    }

}



/* =========================================================
   SMARTRESUME STUDIO 3.0 — PREMIUM UI OVERRIDES
========================================================= */
:root{
    --studio-bg:#0b0c0f;
    --studio-panel:#111318;
    --studio-card:#171a20;
    --studio-line:#292d36;
    --studio-muted:#8d94a3;
    --studio-text:#f5f7fb;
    --studio-lime:#c8ff32;
    --studio-purple:#8b5cf6;
    --studio-blue:#4f8cff;
}

body{background:var(--studio-bg)!important;}
.builder-app{background:var(--studio-bg)!important;}

.topbar{
    height:72px!important;
    padding:0 20px!important;
    background:rgba(12,13,17,.96)!important;
    border-bottom:1px solid #252831!important;
    color:#fff!important;
    box-shadow:0 12px 35px rgba(0,0,0,.16)!important;
}
.top-left,.top-right{width:320px!important;}
.back-button,.top-button:not(.dark){
    background:#15171c!important;
    color:#e9ebf1!important;
    border-color:#2a2e37!important;
}
.back-button:hover,.top-button:not(.dark):hover{background:#20232a!important;transform:translateY(-1px);}
.logo-mini{width:38px!important;height:38px!important;border-radius:12px!important;background:#fff!important;color:#111!important;box-shadow:0 0 0 1px rgba(255,255,255,.12);}
.project-name input{color:#fff!important;font-size:13px!important;}
.project-status{color:#7f8796!important;}
.status-dot{background:var(--studio-lime)!important;box-shadow:0 0 12px rgba(200,255,50,.6)!important;}
.top-center{gap:6px!important;}
.top-tab{color:#7e8593!important;border-radius:10px!important;height:40px!important;padding:0 19px!important;}
.top-tab:hover{background:#191c22!important;color:#fff!important;}
.top-tab.active{background:#fff!important;color:#111!important;box-shadow:0 7px 20px rgba(255,255,255,.08)!important;}
.top-button.dark{background:var(--studio-lime)!important;color:#111!important;border-color:var(--studio-lime)!important;font-weight:950!important;box-shadow:0 8px 24px rgba(200,255,50,.16)!important;}
.top-button.dark:hover{transform:translateY(-1px);box-shadow:0 10px 28px rgba(200,255,50,.24)!important;}
.user-avatar{background:linear-gradient(135deg,#8b5cf6,#4f8cff)!important;color:#fff!important;border:none!important;box-shadow:0 0 0 2px #242731,0 8px 24px rgba(79,140,255,.22)!important;}

.workspace{grid-template-columns:310px minmax(430px,1fr) minmax(510px,1.08fr)!important;background:#0b0c0f!important;}
.editor-panel{background:var(--studio-panel)!important;border-right:1px solid var(--studio-line)!important;color:var(--studio-text)!important;}
.editor-tabs{height:62px!important;padding:0 14px!important;border-bottom:1px solid var(--studio-line)!important;background:#101217!important;}
.editor-tab{height:38px!important;border-radius:11px!important;color:#747c8b!important;}
.editor-tab:hover{background:#191c22!important;color:#fff!important;}
.editor-tab.active{background:#242831!important;color:#fff!important;box-shadow:inset 0 0 0 1px #343944!important;}
.editor-scroll{padding:18px!important;background:linear-gradient(180deg,#111318 0%,#0f1116 100%)!important;}
.editor-scroll::-webkit-scrollbar-thumb{background:#303540!important;}
.section-block{margin-bottom:16px!important;padding:17px!important;border:1px solid var(--studio-line)!important;border-radius:17px!important;background:linear-gradient(145deg,#181b21,#14171c)!important;box-shadow:0 10px 30px rgba(0,0,0,.16)!important;}
.section-heading{margin-bottom:15px!important;}
.section-heading-icon{width:34px!important;height:34px!important;border-radius:10px!important;background:linear-gradient(135deg,#242832,#1b1e25)!important;color:#c8ff32!important;border:1px solid #303540!important;}
.section-heading h3{color:#f7f8fb!important;font-size:12px!important;}
.section-heading p{color:#7d8492!important;}
.field label{color:#7f8795!important;font-size:8px!important;letter-spacing:.7px!important;}
.field input,.field textarea,.field select{background:#0f1116!important;border-color:#2b3039!important;color:#f4f6fa!important;border-radius:10px!important;padding:11px 12px!important;}
.field input::placeholder,.field textarea::placeholder{color:#555d6b!important;}
.field input:focus,.field textarea:focus,.field select:focus{background:#12151b!important;border-color:#7d8798!important;box-shadow:0 0 0 3px rgba(139,92,246,.13)!important;}
.entry-card{background:#101319!important;border-color:#2a2f38!important;border-radius:13px!important;}
.entry-card-title{color:#e9edf5!important;}
.add-button{background:#1d2129!important;color:#e9edf5!important;border-color:#303641!important;border-radius:10px!important;}
.add-button:hover{background:#272c35!important;border-color:#444b58!important;}

.center-panel{background:radial-gradient(circle at 50% 8%,#292d37 0%,#171a20 38%,#0d0f13 100%)!important;}
.center-toolbar{background:rgba(15,17,22,.88)!important;border-bottom:1px solid #282c35!important;color:#fff!important;backdrop-filter:blur(12px)!important;}
.tool-btn{background:#171a20!important;color:#e7eaf0!important;border-color:#303540!important;border-radius:10px!important;}
.tool-btn:hover{background:#242832!important;}
.zoom{color:#9299a7!important;}
.canvas{padding:48px 40px 100px!important;}
.paper-wrapper{filter:drop-shadow(0 30px 50px rgba(0,0,0,.42));}
.paper{border-radius:3px!important;overflow:hidden!important;box-shadow:0 0 0 1px rgba(255,255,255,.15),0 35px 80px rgba(0,0,0,.34)!important;}

.preview-panel{background:#111318!important;border-left:1px solid #292d36!important;}
.preview-header{height:62px!important;background:#101217!important;border-bottom:1px solid #292d36!important;color:#fff!important;}
.preview-title{color:#f7f8fb!important;letter-spacing:.7px!important;}
.preview-header::after{content:"LIVE · AUTO PREVIEW";font-size:8px;font-weight:900;letter-spacing:.8px;color:#c8ff32;margin-left:auto;margin-right:12px;}
.preview-body{padding:42px 26px 90px!important;background:radial-gradient(circle at 50% 10%,#252a33 0%,#14171c 50%,#0e1014 100%)!important;}
.preview-paper{border-radius:3px!important;box-shadow:0 28px 70px rgba(0,0,0,.48),0 0 0 1px rgba(255,255,255,.12)!important;}

.design-panel .design-group{padding:16px!important;margin-bottom:12px!important;border:1px solid #2a2f38!important;border-radius:15px!important;background:#171a20!important;}
.design-label{color:#89919f!important;letter-spacing:1px!important;}
.template-option{background:#111419!important;border-color:#2b3039!important;border-radius:14px!important;box-shadow:0 8px 20px rgba(0,0,0,.18)!important;}
.template-option:hover{border-color:#606978!important;transform:translateY(-3px)!important;}
.template-option.selected{border-color:#c8ff32!important;box-shadow:0 0 0 1px #c8ff32,0 12px 28px rgba(200,255,50,.10)!important;}
.template-option.selected::after{background:#c8ff32!important;}
.color-option{box-shadow:0 0 0 3px #171a20!important;outline:1px solid #3a404b!important;}
.color-option.selected{outline:2px solid #c8ff32!important;}
.range-value{color:#b8bfca!important;}

.studio-photo-card{display:grid;grid-template-columns:58px 1fr auto;gap:12px;align-items:center;padding:13px;border:1px solid #2b3039;border-radius:14px;background:linear-gradient(135deg,#191c23,#12151a);margin-top:14px;}
.studio-photo-preview{width:58px;height:58px;border-radius:50%;overflow:hidden;display:flex;align-items:center;justify-content:center;background:#252a33;border:2px solid #3a404b;color:#777;font-size:8px;font-weight:900;letter-spacing:.5px;}
.studio-photo-preview img{width:100%;height:100%;object-fit:cover;display:block;}
.studio-photo-title{font-size:10px;font-weight:900;color:#f1f3f7;}
.studio-photo-sub{font-size:8px;color:#7f8794;margin-top:4px;line-height:1.45;}
.studio-photo-btn{border:1px solid #3a404b;background:#f2f4f7;color:#111;border-radius:9px;padding:9px 11px;font-size:8px;font-weight:950;cursor:pointer;white-space:nowrap;}
.studio-photo-btn:hover{background:#c8ff32;border-color:#c8ff32;}

.studio-toast{position:fixed;right:24px;bottom:24px;z-index:9999;min-width:230px;padding:13px 15px;border:1px solid #333944;border-radius:13px;background:rgba(17,19,24,.96);box-shadow:0 18px 45px rgba(0,0,0,.35);color:#fff;font-size:10px;font-weight:800;opacity:0;transform:translateY(12px);pointer-events:none;transition:.25s;backdrop-filter:blur(12px);}
.studio-toast.show{opacity:1;transform:translateY(0);}
.studio-toast.success{border-color:rgba(200,255,50,.45);}.studio-toast.error{border-color:rgba(255,90,90,.5);}

@media(max-width:1200px){.workspace{grid-template-columns:300px minmax(420px,1fr)!important}.preview-panel{display:none!important}.top-left,.top-right{width:300px!important;}}

</style>

</head>


<body>


<div id="studioToast" class="studio-toast"></div>

<div class="builder-app">


<!-- =========================================================
     TOP BAR
========================================================= -->

<header class="topbar">


    <div class="top-left">

        <a
            href="<%= contextPath %>/dashboard"
            class="back-button"
            title="Back to dashboard"
        >
            ←
        </a>


        <div class="logo-mini">
            S
        </div>


        <div class="project-name">

            <input
                id="resumeTitle"
                value="<%= escHtml(loadedTitle) %>"
                maxlength="80"
            >

            <div class="project-status">

                <span class="status-dot"></span>

                <span id="saveStatus">
                    Saved just now
                </span>

            </div>

        </div>

    </div>


    <div class="top-center">

        <button
            class="top-tab active"
            onclick="setWorkspaceTab(this,'editor')"
        >
            Build
        </button>

        <button
            class="top-tab"
            onclick="setWorkspaceTab(this,'design')"
        >
            Design
        </button>

        <button
            class="top-tab"
            onclick="setWorkspaceTab(this,'sections')"
        >
            Sections
        </button>

    </div>


    <div class="top-right">

        <button
            class="top-button"
            onclick="zoomOut()"
        >
            −
        </button>

        <span
            id="zoomValue"
            style="
                min-width:32px;
                text-align:center;
                font-size:9px;
                color:#777;
            "
        >
            70%
        </span>

        <button
            class="top-button"
            onclick="zoomIn()"
        >
            +
        </button>

        <button
            class="top-button"
            onclick="window.print()"
        >
            ⎙ Print
        </button>

        <button
            class="top-button dark"
            onclick="saveResume()"
        >
            Save
        </button>

        <div class="user-avatar">
            <%= avatarLetter %>
        </div>

    </div>

</header>


<!-- =========================================================
     WORKSPACE
========================================================= -->

<div class="workspace">


<!-- =========================================================
     LEFT EDITOR
========================================================= -->

<aside
    class="editor-panel"
    id="editorPanel"
>


    <div class="editor-tabs">

        <button
            class="editor-tab active"
            onclick="openPanel('content',this)"
        >
            CONTENT
        </button>

        <button
            class="editor-tab"
            onclick="openPanel('design',this)"
        >
            DESIGN
        </button>

        <button
            class="editor-tab"
            onclick="openPanel('sections',this)"
        >
            SECTIONS
        </button>

    </div>


    <div class="editor-scroll">


<!-- =========================================================
     CONTENT PANEL
========================================================= -->

<div id="contentPanel">


<!-- PERSONAL -->

<div class="section-block">

    <div class="section-heading">

        <div class="section-heading-left">

            <div class="section-heading-icon">
                ◉
            </div>

            <div>

                <h3>
                    Personal information
                </h3>

                <p>
                    Make a strong first impression
                </p>

            </div>

        </div>

    </div>


    <div class="field">

        <label>
            FULL NAME
        </label>

        <input
            id="fullName"
            value="<%= escHtml(fullName) %>"
            placeholder="Alex Morgan"
            oninput="updatePreview()"
        >

    </div>


    <div class="two-fields">

        <div class="field">

            <label>
                EMAIL
            </label>

            <input
                id="email"
                value="<%= escHtml(email) %>"
                placeholder="alex@email.com"
                oninput="updatePreview()"
            >

        </div>


        <div class="field">

            <label>
                PHONE
            </label>

            <input
                id="phone"
                value="<%= escHtml(phone) %>"
                placeholder="+91 98765 43210"
                oninput="updatePreview()"
            >

        </div>

    </div>


    <div class="field">

        <label>
            LOCATION
        </label>

        <input
            id="location"
            value="<%= escHtml(location) %>"
                placeholder="Mumbai, India"
            oninput="updatePreview()"
        >

    </div>


    <div class="two-fields">

        <div class="field">

            <label>
                LINKEDIN
            </label>

            <input
                id="linkedin"
                value="<%= escHtml(linkedin) %>"
                placeholder="linkedin.com/in/..."
                oninput="updatePreview()"
            >

        </div>


        <div class="field">

            <label>
                GITHUB
            </label>

            <input
                id="github"
                value="<%= escHtml(github) %>"
                placeholder="github.com/..."
                oninput="updatePreview()"
            >

        </div>

    </div>

</div>

<div class="studio-photo-card">
    <div class="studio-photo-preview" id="studioPhotoPreview">
        <% if (!profilePhoto.isEmpty()) { %>
            <img src="<%= profilePhoto %>" alt="Profile photo">
        <% } else { %>
            PHOTO
        <% } %>
    </div>
    <div>
        <div class="studio-photo-title">Profile photo</div>
        <div class="studio-photo-sub">JPG, PNG or WEBP · max 5 MB<br>Used automatically in supported templates.</div>
    </div>
    <div>
        <input id="profilePhotoInput" type="file" accept="image/png,image/jpeg,image/webp" hidden onchange="handleProfilePhoto(this)">
        <button type="button" class="studio-photo-btn" onclick="document.getElementById('profilePhotoInput').click()">Upload</button>
    </div>
</div>


<!-- SUMMARY -->

<div class="section-block">

    <div class="section-heading">

        <div class="section-heading-left">

            <div class="section-heading-icon">
                ✦
            </div>

            <div>

                <h3>
                    Professional summary
                </h3>

                <p>
                    A concise introduction
                </p>

            </div>

        </div>

    </div>


    <div class="field">

        <textarea
            id="summary"
            placeholder="Write a short professional summary..."
            oninput="updatePreview()"
        ><%= escHtml(summary) %></textarea>

    </div>

</div>


<!-- EXPERIENCE -->

<div class="section-block">

    <div class="section-heading">

        <div class="section-heading-left">

            <div class="section-heading-icon">
                ↗
            </div>

            <div>

                <h3>
                    Experience
                </h3>

                <p>
                    Your professional journey
                </p>

            </div>

        </div>

    </div>


    <div id="experienceContainer">


        <div class="entry-card">

            <div class="entry-card-head">

                <span class="entry-card-title">
                    Experience 01
                </span>

                <button
                    class="remove-entry"
                    onclick="removeEntry(this)"
                >
                    ×
                </button>

            </div>


            <div class="field">

                <label>
                    JOB TITLE
                </label>

                <input
                    class="exp-role"
                    placeholder="Software Developer"
                    oninput="updatePreview()"
                >

            </div>


            <div class="field">

                <label>
                    COMPANY
                </label>

                <input
                    class="exp-company"
                    placeholder="Company name"
                    oninput="updatePreview()"
                >

            </div>


            <div class="two-fields">

                <div class="field">

                    <label>
                        START
                    </label>

                    <input
                        class="exp-start"
                        placeholder="Jan 2025"
                        oninput="updatePreview()"
                    >

                </div>


                <div class="field">

                    <label>
                        END
                    </label>

                    <input
                        class="exp-end"
                        placeholder="Present"
                        oninput="updatePreview()"
                    >

                </div>

            </div>


            <div class="field">

                <label>
                    DESCRIPTION
                </label>

                <textarea
                    class="exp-description"
                    placeholder="Describe your impact..."
                    oninput="updatePreview()"
                ></textarea>

            </div>

        </div>


    </div>


    <button
        class="add-button"
        onclick="addExperience()"
    >
        + Add experience
    </button>

</div>


<!-- EDUCATION -->

<div class="section-block">

    <div class="section-heading">

        <div class="section-heading-left">

            <div class="section-heading-icon">
                ◇
            </div>

            <div>

                <h3>
                    Education
                </h3>

                <p>
                    Academic background
                </p>

            </div>

        </div>

    </div>


    <div id="educationContainer">


        <div class="entry-card">

            <div class="entry-card-head">

                <span class="entry-card-title">
                    Education 01
                </span>

                <button
                    class="remove-entry"
                    onclick="removeEntry(this)"
                >
                    ×
                </button>

            </div>


            <div class="field">

                <label>
                    DEGREE
                </label>

                <input
                    class="edu-degree"
                    placeholder="B.E. Information Technology"
                    oninput="updatePreview()"
                >

            </div>


            <div class="field">

                <label>
                    INSTITUTION
                </label>

                <input
                    class="edu-school"
                    placeholder="University / College"
                    oninput="updatePreview()"
                >

            </div>


            <div class="two-fields">

                <div class="field">

                    <label>
                        START
                    </label>

                    <input
                        class="edu-start"
                        placeholder="2024"
                        oninput="updatePreview()"
                    >

                </div>


                <div class="field">

                    <label>
                        END
                    </label>

                    <input
                        class="edu-end"
                        placeholder="2028"
                        oninput="updatePreview()"
                    >

                </div>

            </div>

        </div>


    </div>


    <button
        class="add-button"
        onclick="addEducation()"
    >
        + Add education
    </button>

</div>


<!-- PROJECTS -->

<div class="section-block">

    <div class="section-heading">

        <div class="section-heading-left">

            <div class="section-heading-icon">
                ◈
            </div>

            <div>

                <h3>
                    Projects
                </h3>

                <p>
                    Show what you've built
                </p>

            </div>

        </div>

    </div>


    <div id="projectsContainer">


        <div class="entry-card">

            <div class="entry-card-head">

                <span class="entry-card-title">
                    Project 01
                </span>

                <button
                    class="remove-entry"
                    onclick="removeEntry(this)"
                >
                    ×
                </button>

            </div>


            <div class="field">

                <label>
                    PROJECT NAME
                </label>

                <input
                    class="project-name"
                    placeholder="SmartResume"
                    oninput="updatePreview()"
                >

            </div>


            <div class="field">

                <label>
                    TECHNOLOGIES
                </label>

                <input
                    class="project-tech"
                    placeholder="Java, JSP, Servlets, MySQL"
                    oninput="updatePreview()"
                >

            </div>


            <div class="field">

                <label>
                    DESCRIPTION
                </label>

                <textarea
                    class="project-description"
                    placeholder="Describe your project..."
                    oninput="updatePreview()"
                ></textarea>

            </div>

        </div>


    </div>


    <button
        class="add-button"
        onclick="addProject()"
    >
        + Add project
    </button>

</div>


<!-- SKILLS -->

<div class="section-block">

    <div class="section-heading">

        <div class="section-heading-left">

            <div class="section-heading-icon">
                #
            </div>

            <div>

                <h3>
                    Skills
                </h3>

                <p>
                    Highlight your strengths
                </p>

            </div>

        </div>

    </div>


    <div class="field">

        <textarea
            id="skills"
            placeholder="Java, Python, SQL, HTML, CSS, JavaScript..."
            oninput="updatePreview()"
        ><%= escHtml(skills) %></textarea>

    </div>

</div>


<!-- CERTIFICATIONS -->

<div class="section-block">

    <div class="section-heading">

        <div class="section-heading-left">

            <div class="section-heading-icon">
                ✓
            </div>

            <div>

                <h3>
                    Certifications
                </h3>

                <p>
                    Credentials & courses
                </p>

            </div>

        </div>

    </div>


    <div class="field">

        <textarea
            id="certifications"
            placeholder="Google AI Essentials&#10;AWS Cloud Practitioner"
            oninput="updatePreview()"
        ><%= escHtml(certifications) %></textarea>

    </div>

</div>


<!-- LANGUAGES -->

<div class="section-block">

    <div class="section-heading">

        <div class="section-heading-left">

            <div class="section-heading-icon">
                A
            </div>

            <div>

                <h3>
                    Languages
                </h3>

                <p>
                    Languages you speak
                </p>

            </div>

        </div>

    </div>


    <div class="field">

        <input
            id="languages"
            placeholder="English, Hindi, Marathi"
            oninput="updatePreview()"
        ><%= escHtml(languages) %>

    </div>

</div>


<!-- ACHIEVEMENTS -->

<div class="section-block">

    <div class="section-heading">

        <div class="section-heading-left">

            <div class="section-heading-icon">
                ★
            </div>

            <div>

                <h3>
                    Achievements
                </h3>

                <p>
                    Stand-out accomplishments
                </p>

            </div>

        </div>

    </div>


    <div class="field">

        <textarea
            id="achievements"
            placeholder="Hackathon finalist&#10;Academic achievement..."
            oninput="updatePreview()"
        ><%= escHtml(achievements) %></textarea>

    </div>

</div>


<!-- INTERESTS -->

<div class="section-block">

    <div class="section-heading">

        <div class="section-heading-left">

            <div class="section-heading-icon">
                ♢
            </div>

            <div>

                <h3>
                    Interests
                </h3>

                <p>
                    Optional personal touch
                </p>

            </div>

        </div>

    </div>


    <div class="field">

        <input
            id="interests"
            placeholder="Cricket, Technology, Photography"
            oninput="updatePreview()"
        ><%= escHtml(interests) %>

    </div>

</div>


</div>


<!-- =========================================================
     DESIGN PANEL
========================================================= -->

<div
    id="designPanel"
    class="design-panel"
>


<div class="design-group">

    <div class="design-label">
        TEMPLATE
    </div>


    <div class="template-mini-grid">


        <!-- MODERN -->

        <div
            class="template-option selected"
            data-template="modern"
            onclick="selectTemplate(this,'modern')"
        >

            <div class="mini-paper">

                <div
                    class="line dark"
                    style="width:65%;"
                ></div>

                <div
                    class="line"
                    style="width:42%;"
                ></div>

                <br>

                <div
                    class="line dark"
                    style="width:35%;"
                ></div>

                <div class="line"></div>

                <div
                    class="line"
                    style="width:85%;"
                ></div>

                <br>

                <div
                    class="line dark"
                    style="width:35%;"
                ></div>

                <div class="line"></div>

            </div>

        </div>


        <!-- SIDEBAR -->

        <div
            class="template-option"
            data-template="sidebar"
            onclick="selectTemplate(this,'sidebar')"
        >

            <div class="mini-paper sidebar-layout">

                <div class="side"></div>

                <div class="mini-content">

                    <div class="line dark"></div>

                    <div class="line"></div>

                    <br>

                    <div class="line dark"></div>

                    <div class="line"></div>

                    <div class="line"></div>

                </div>

            </div>

        </div>


        <!-- CLASSIC -->

        <div
            class="template-option"
            data-template="classic"
            onclick="selectTemplate(this,'classic')"
        >

            <div
                class="mini-paper"
                style="font-family:Georgia,serif;"
            >

                <div
                    class="line dark"
                    style="width:85%;height:5px;"
                ></div>

                <div
                    class="line"
                    style="width:45%;"
                ></div>

                <hr
                    style="
                        border:none;
                        border-top:1px solid #222;
                        margin:8px 0;
                    "
                >

                <div
                    class="line dark"
                    style="width:38%;"
                ></div>

                <div class="line"></div>

                <div class="line"></div>

            </div>

        </div>


        <!-- MINIMAL -->

        <div
            class="template-option"
            data-template="minimal"
            onclick="selectTemplate(this,'minimal')"
        >

            <div
                class="mini-paper"
                style="padding-top:18px;"
            >

                <div
                    class="line dark"
                    style="width:45%;height:4px;"
                ></div>

                <br>

                <div class="line"></div>

                <div
                    class="line"
                    style="width:90%;"
                ></div>

                <div
                    class="line"
                    style="width:75%;"
                ></div>

                <br>

                <div class="line"></div>

                <div
                    class="line"
                    style="width:80%;"
                ></div>

            </div>

        </div>


        <!-- EXECUTIVE -->

        <div
            class="template-option"
            data-template="executive"
            onclick="selectTemplate(this,'executive')"
        >

            <div
                class="mini-paper"
                style="font-family:Georgia,serif;"
            >

                <div
                    class="line dark"
                    style="width:75%;height:5px;"
                ></div>

                <div
                    class="line"
                    style="width:42%;"
                ></div>

                <hr
                    style="
                        border:none;
                        border-top:1px solid #222;
                        margin:8px 0;
                    "
                >

                <div
                    class="line dark"
                    style="width:38%;"
                ></div>

                <div class="line"></div>

                <div
                    class="line"
                    style="width:75%;"
                ></div>

            </div>

        </div>


        <!-- CREATIVE -->

        <div
            class="template-option"
            data-template="creative"
            onclick="selectTemplate(this,'creative')"
        >

            <div class="mini-paper">

                <div
                    style="
                        width:70%;
                        height:7px;
                        background:#7c3aed;
                        margin-bottom:5px;
                    "
                ></div>

                <div
                    class="line"
                    style="width:48%;"
                ></div>

                <br>

                <div
                    style="
                        border-left:3px solid #7c3aed;
                        padding-left:4px;
                    "
                >

                    <div
                        class="line dark"
                        style="width:42%;"
                    ></div>

                    <div class="line"></div>

                </div>

                <br>

                <div
                    style="
                        border-left:3px solid #7c3aed;
                        padding-left:4px;
                    "
                >

                    <div
                        class="line dark"
                        style="width:42%;"
                    ></div>

                    <div
                        class="line"
                        style="width:80%;"
                    ></div>

                </div>

            </div>

        </div>


        <!-- DEVELOPER -->

        <div
            class="template-option"
            data-template="developer"
            onclick="selectTemplate(this,'developer')"
        >

            <div
                class="mini-paper"
                style="font-family:monospace;"
            >

                <div
                    class="line dark"
                    style="width:70%;"
                ></div>

                <div
                    class="line"
                    style="width:45%;"
                ></div>

                <br>

                <div
                    style="
                        border-top:1px dashed #222;
                        padding-top:5px;
                    "
                >

                    <div
                        class="line dark"
                        style="width:40%;"
                    ></div>

                    <div class="line"></div>

                    <div class="line"></div>

                </div>

                <br>

                <div
                    class="line dark"
                    style="width:35%;"
                ></div>

                <div
                    class="line"
                    style="width:80%;"
                ></div>

            </div>

        </div>


        <!-- CORPORATE -->

        <div
            class="template-option"
            data-template="corporate"
            onclick="selectTemplate(this,'corporate')"
        >

            <div
                class="mini-paper"
                style="padding:0;"
            >

                <div
                    style="
                        height:18px;
                        background:#2563eb;
                        padding:5px;
                    "
                >

                    <div
                        style="
                            width:55%;
                            height:3px;
                            background:white;
                        "
                    ></div>

                </div>

                <div
                    style="
                        padding:6px;
                    "
                >

                    <div
                        class="line dark"
                        style="width:40%;"
                    ></div>

                    <div class="line"></div>

                    <div class="line"></div>

                    <br>

                    <div
                        class="line dark"
                        style="width:40%;"
                    ></div>

                    <div class="line"></div>

                </div>

            </div>

        </div>


    </div>

</div>


<!-- COLORS -->

<div class="design-group">

    <div class="design-label">
        ACCENT COLOR
    </div>


    <div class="color-row">

        <div
            class="color-option color-black selected"
            data-color="#111111"
            onclick="selectColor(this)"
        ></div>

        <div
            class="color-option color-blue"
            data-color="#2563eb"
            onclick="selectColor(this)"
        ></div>

        <div
            class="color-option color-green"
            data-color="#16a34a"
            onclick="selectColor(this)"
        ></div>

        <div
            class="color-option color-purple"
            data-color="#7c3aed"
            onclick="selectColor(this)"
        ></div>

        <div
            class="color-option color-red"
            data-color="#dc2626"
            onclick="selectColor(this)"
        ></div>

        <div
            class="color-option color-orange"
            data-color="#ea580c"
            onclick="selectColor(this)"
        ></div>

        <div
            class="color-option color-teal"
            data-color="#0f766e"
            onclick="selectColor(this)"
        ></div>

        <div
            class="color-option color-pink"
            data-color="#db2777"
            onclick="selectColor(this)"
        ></div>

    </div>

</div>


<!-- FONT -->

<div class="design-group">

    <div class="design-label">
        FONT
    </div>


    <select
        id="fontSelect"
        onchange="changeFont(this.value)"
        style="
            width:100%;
            padding:10px;
            border:1px solid #ddd;
            border-radius:8px;
            background:#fafaf8;
            outline:none;
            font-size:10px;
        "
    >

        <option value="Arial">
            Arial
        </option>

        <option value="Georgia">
            Georgia
        </option>

        <option value="Verdana">
            Verdana
        </option>

        <option value="'Trebuchet MS'">
            Trebuchet MS
        </option>

        <option value="'Times New Roman'">
            Times New Roman
        </option>

    </select>

</div>


<!-- FONT SIZE -->

<div class="design-group">

    <div class="design-label">
        NAME SIZE
    </div>


    <div class="range-row">

        <input
            type="range"
            min="28"
            max="46"
            value="35"
            id="fontSizeRange"
            oninput="changeFontSize(this.value)"
        >

        <span
            class="range-value"
            id="fontSizeValue"
        >
            35
        </span>

    </div>

</div>


<!-- SPACING -->

<div class="design-group">

    <div class="design-label">
        PAGE SPACING
    </div>


    <div class="range-row">

        <input
            type="range"
            min="40"
            max="80"
            value="58"
            id="spacingRange"
            oninput="changeSpacing(this.value)"
        >

        <span
            class="range-value"
            id="spacingValue"
        >
            58
        </span>

    </div>

</div>


</div>


<!-- =========================================================
     SECTIONS PANEL
========================================================= -->

<div
    id="sectionsPanel"
    class="sections-panel"
>


<div class="section-block">

    <div class="section-heading">

        <div class="section-heading-left">

            <div class="section-heading-icon">
                ☷
            </div>

            <div>

                <h3>
                    Resume sections
                </h3>

                <p>
                    Control what appears on your resume
                </p>

            </div>

        </div>

    </div>


<%
String[][] sectionNames = {
    {"Summary", "summarySection"},
    {"Experience", "experienceSection"},
    {"Education", "educationSection"},
    {"Projects", "projectsSection"},
    {"Skills", "skillsSection"},
    {"Certifications", "certificationsSection"},
    {"Languages", "languagesSection"},
    {"Achievements", "achievementsSection"},
    {"Interests", "interestsSection"}
};

for (String[] section : sectionNames) {
%>

    <div class="section-toggle-row">

        <div class="section-toggle-info">

            <span class="drag">
                ⋮⋮
            </span>

            <span
                style="
                    font-size:10px;
                    font-weight:700;
                "
            >
                <%= section[0] %>
            </span>

        </div>


        <span
            class="toggle on"
            onclick="
                toggleSection(
                    this,
                    '<%= section[1] %>'
                )
            "
        ></span>

    </div>

<%
}
%>


</div>

</div>


    </div>

</aside>


<!-- =========================================================
     CENTER CANVAS
========================================================= -->

<section class="center-panel">


<div class="center-toolbar">

    <div class="toolbar-left">

        <button
            class="tool-btn"
            onclick="zoomOut()"
        >
            −
        </button>

        <span
            class="zoom"
            id="centerZoom"
        >
            70%
        </span>

        <button
            class="tool-btn"
            onclick="zoomIn()"
        >
            +
        </button>

        <button
            class="tool-btn"
            onclick="resetZoom()"
        >
            ↺
        </button>

    </div>


    <div class="toolbar-right">

        <button
            class="tool-btn"
            onclick="window.print()"
        >
            ⎙
        </button>

        <button
            class="tool-btn"
            onclick="toggleFullPreview()"
        >
            ⛶
        </button>

    </div>

</div>


<div class="canvas">


<div
    class="paper-wrapper"
    id="paperWrapper"
>


<div
    class="paper template-modern"
    id="paper"
>


<!-- HEADER -->

<div class="paper-header">

    <div>

        <div
            class="paper-name"
            id="previewName"
        >
            <%= fullName.isEmpty()
                ? "Your Name"
                : fullName %>
        </div>

        <div class="paper-role">
            PROFESSIONAL
        </div>

    </div>


    <div class="paper-photo">
        <% if (!profilePhoto.isEmpty()) { %>
            <img src="<%= profilePhoto %>" alt="Profile Photo">
        <% } else { %>
            PHOTO
        <% } %>
    </div>

</div>


<!-- CONTACT -->

<div
    class="paper-contact"
    id="previewContact"
>

    <span>
        <%= email.isEmpty()
            ? "email@example.com"
            : email %>
    </span>

    <span>•</span>

    <span>
        Phone
    </span>

    <span>•</span>

    <span>
        Location
    </span>

</div>


<!-- SUMMARY -->

<div
    class="paper-section"
    id="summarySection"
>

    <div class="paper-section-title">
        Profile
    </div>

    <div
        class="paper-summary"
        id="previewSummary"
    >
        Your professional summary will appear here.
    </div>

</div>


<!-- EXPERIENCE -->

<div
    class="paper-section"
    id="experienceSection"
>

    <div class="paper-section-title">
        Experience
    </div>

    <div id="previewExperience">

        <div class="paper-entry">

            <div class="paper-entry-title">
                Your experience
            </div>

            <div class="paper-entry-sub">
                Company Name
            </div>

            <div class="paper-entry-description">
                Your professional experience will appear here.
            </div>

        </div>

    </div>

</div>


<!-- EDUCATION -->

<div
    class="paper-section"
    id="educationSection"
>

    <div class="paper-section-title">
        Education
    </div>

    <div id="previewEducation">

        <div class="paper-entry">

            <div class="paper-entry-title">
                Your Degree
            </div>

            <div class="paper-entry-sub">
                University / College
            </div>

        </div>

    </div>

</div>


<!-- PROJECTS -->

<div
    class="paper-section"
    id="projectsSection"
>

    <div class="paper-section-title">
        Projects
    </div>

    <div id="previewProjects">

        <div class="paper-entry">

            <div class="paper-entry-title">
                Your project
            </div>

            <div class="paper-entry-sub">
                Technologies
            </div>

            <div class="paper-entry-description">
                Your project description will appear here.
            </div>

        </div>

    </div>

</div>


<!-- SKILLS -->

<div
    class="paper-section"
    id="skillsSection"
>

    <div class="paper-section-title">
        Skills
    </div>

    <div
        class="paper-skills"
        id="previewSkills"
    >

        <span class="paper-skill">
            Java
        </span>

        <span class="paper-skill">
            SQL
        </span>

        <span class="paper-skill">
            HTML
        </span>

        <span class="paper-skill">
            CSS
        </span>

    </div>

</div>


<!-- CERTIFICATIONS -->

<div
    class="paper-section"
    id="certificationsSection"
>

    <div class="paper-section-title">
        Certifications
    </div>

    <div
        class="paper-summary"
        id="previewCertifications"
    >
        Certifications will appear here.
    </div>

</div>


<!-- LANGUAGES -->

<div
    class="paper-section"
    id="languagesSection"
>

    <div class="paper-section-title">
        Languages
    </div>

    <div
        class="paper-summary"
        id="previewLanguages"
    >
        English • Hindi • Marathi
    </div>

</div>


<!-- ACHIEVEMENTS -->

<div
    class="paper-section"
    id="achievementsSection"
>

    <div class="paper-section-title">
        Achievements
    </div>

    <div
        class="paper-summary"
        id="previewAchievements"
    >
        Your achievements will appear here.
    </div>

</div>


<!-- INTERESTS -->

<div
    class="paper-section"
    id="interestsSection"
>

    <div class="paper-section-title">
        Interests
    </div>

    <div
        class="paper-summary"
        id="previewInterests"
    >
        Your interests will appear here.
    </div>

</div>


</div>

</div>

</div>

</section>


<!-- =========================================================
     RIGHT LIVE PREVIEW
========================================================= -->

<section class="preview-panel">


<div class="preview-header">

    <div>

        <div class="preview-title">
            LIVE PREVIEW
        </div>

        <div
            style="
                color:#999;
                font-size:8px;
                margin-top:3px;
            "
        >
            Changes update instantly
        </div>

    </div>


    <div
        style="
            display:flex;
            gap:5px;
        "
    >

        <button
            class="tool-btn"
            onclick="zoomOutPreview()"
        >
            −
        </button>

        <button
            class="tool-btn"
            onclick="zoomInPreview()"
        >
            +
        </button>

    </div>

</div>


<div class="preview-body">


<div
    class="preview-paper template-modern"
    id="previewPaper"
>


<div class="paper-header">

    <div>

        <div
            class="paper-name"
            id="rightPreviewName"
        >
            <%= fullName.isEmpty()
                ? "Your Name"
                : fullName %>
        </div>

        <div class="paper-role">
            PROFESSIONAL
        </div>

    </div>


    <div class="paper-photo">
        <% if (!profilePhoto.isEmpty()) { %>
            <img src="<%= profilePhoto %>" alt="Profile Photo">
        <% } else { %>
            PHOTO
        <% } %>
    </div>

</div>


<div
    class="paper-contact"
    id="rightPreviewContact"
>

    <span>
        <%= email.isEmpty()
            ? "email@example.com"
            : email %>
    </span>

    <span>•</span>

    <span>Phone</span>

    <span>•</span>

    <span>Location</span>

</div>


<div class="paper-section">

    <div class="paper-section-title">
        Profile
    </div>

    <div
        class="paper-summary"
        id="rightPreviewSummary"
    >
        Your professional summary will appear here.
    </div>

</div>


<div class="paper-section">

    <div class="paper-section-title">
        Experience
    </div>

    <div id="rightPreviewExperience">

        <div class="paper-entry">

            <div class="paper-entry-title">
                Your experience
            </div>

            <div class="paper-entry-sub">
                Company Name
            </div>

            <div class="paper-entry-description">
                Your professional experience will appear here.
            </div>

        </div>

    </div>

</div>


<div class="paper-section">

    <div class="paper-section-title">
        Education
    </div>

    <div id="rightPreviewEducation">

        <div class="paper-entry">

            <div class="paper-entry-title">
                Your Degree
            </div>

            <div class="paper-entry-sub">
                University / College
            </div>

        </div>

    </div>

</div>


<div class="paper-section">

    <div class="paper-section-title">
        Projects
    </div>

    <div id="rightPreviewProjects">

        <div class="paper-entry">

            <div class="paper-entry-title">
                Your project
            </div>

            <div class="paper-entry-sub">
                Technologies
            </div>

            <div class="paper-entry-description">
                Your project description will appear here.
            </div>

        </div>

    </div>

</div>


<div class="paper-section">

    <div class="paper-section-title">
        Skills
    </div>

    <div
        class="paper-skills"
        id="rightPreviewSkills"
    >

        <span class="paper-skill">
            Java
        </span>

        <span class="paper-skill">
            SQL
        </span>

        <span class="paper-skill">
            HTML
        </span>

        <span class="paper-skill">
            CSS
        </span>

    </div>

</div>


</div>

</div>

</section>


</div>

</div>


<!-- =========================================================
     JAVASCRIPT
========================================================= -->

<script>

/* =========================================================
   STATE
========================================================= */

let currentZoom = 0.70;

let currentPreviewZoom = 0.70;

let currentTemplate = "modern";

let currentColor = "#111111";

let currentFont = "Arial";

let currentFontSize = 35;

let currentSpacing = 58;


/* =========================================================
   INITIALIZE
========================================================= */

function loadSavedEntries() {
    const experienceData = parseSavedJSON("<%= java.util.Base64.getEncoder().encodeToString(experience.getBytes(java.nio.charset.StandardCharsets.UTF_8)) %>");
    const educationData = parseSavedJSON("<%= java.util.Base64.getEncoder().encodeToString(education.getBytes(java.nio.charset.StandardCharsets.UTF_8)) %>");
    const projectData = parseSavedJSON("<%= java.util.Base64.getEncoder().encodeToString(projects.getBytes(java.nio.charset.StandardCharsets.UTF_8)) %>");

    if (experienceData.length) {
        document.getElementById("experienceContainer").innerHTML = "";
        experienceData.forEach(function(item) { addExperience(); });
        const cards = document.querySelectorAll("#experienceContainer .entry-card");
        experienceData.forEach(function(item, index) {
            const card = cards[index];
            card.querySelector(".exp-role").value = item.role || "";
            card.querySelector(".exp-company").value = item.company || "";
            card.querySelector(".exp-start").value = item.start || "";
            card.querySelector(".exp-end").value = item.end || "";
            card.querySelector(".exp-description").value = item.description || "";
        });
    }

    if (educationData.length) {
        document.getElementById("educationContainer").innerHTML = "";
        educationData.forEach(function(item) { addEducation(); });
        const cards = document.querySelectorAll("#educationContainer .entry-card");
        educationData.forEach(function(item, index) {
            const card = cards[index];
            card.querySelector(".edu-degree").value = item.degree || "";
            card.querySelector(".edu-school").value = item.school || "";
            card.querySelector(".edu-start").value = item.start || "";
            card.querySelector(".edu-end").value = item.end || "";
        });
    }

    if (projectData.length) {
        document.getElementById("projectsContainer").innerHTML = "";
        projectData.forEach(function(item) { addProject(); });
        const cards = document.querySelectorAll("#projectsContainer .entry-card");
        projectData.forEach(function(item, index) {
            const card = cards[index];
            card.querySelector(".project-name").value = item.name || "";
            card.querySelector(".project-tech").value = item.tech || "";
            card.querySelector(".project-description").value = item.description || "";
        });
    }
}

function parseSavedJSON(base64) {
    if (!base64) return [];
    try {
        const json = decodeURIComponent(Array.prototype.map.call(atob(base64), function(c) {
            return "%" + ("00" + c.charCodeAt(0).toString(16)).slice(-2);
        }).join(""));
        const parsed = JSON.parse(json);
        return Array.isArray(parsed) ? parsed : [];
    } catch (e) {
        return [];
    }
}

document.addEventListener(
    "DOMContentLoaded",
    function () {


        loadSavedEntries();

        applyTemplate("<%= escHtml(loadedTemplate) %>");
        applyColor("<%= escHtml(loadedThemeColor) %>");

        const selectedTemplate = document.querySelector('.template-option[data-template="<%= escHtml(loadedTemplate) %>"]');
        if (selectedTemplate) {
            document.querySelectorAll(".template-option").forEach(function(option) { option.classList.remove("selected"); });
            selectedTemplate.classList.add("selected");
        }

        const selectedColor = document.querySelector('.color-option[data-color="<%= escHtml(loadedThemeColor) %>"]');
        if (selectedColor) {
            document.querySelectorAll(".color-option").forEach(function(option) { option.classList.remove("selected"); });
            selectedColor.classList.add("selected");
        }

        updatePreview();
        applyZoom();
        applyPreviewZoom();

    }
);


/* =========================================================
   PANEL SWITCH
========================================================= */

function openPanel(
    panel,
    button
) {

    const content =
        document.getElementById(
            "contentPanel"
        );

    const design =
        document.getElementById(
            "designPanel"
        );

    const sections =
        document.getElementById(
            "sectionsPanel"
        );


    content.style.display = "none";

    design.classList.remove("active");

    sections.classList.remove("active");


    if (panel === "content") {

        content.style.display =
            "block";

    }


    if (panel === "design") {

        design.classList.add(
            "active"
        );

    }


    if (panel === "sections") {

        sections.classList.add(
            "active"
        );

    }


    document
        .querySelectorAll(".editor-tab")
        .forEach(
            function (tab) {

                tab.classList.remove(
                    "active"
                );

            }
        );


    if (button) {

        button.classList.add(
            "active"
        );

    }

}


/* =========================================================
   TOP TABS
========================================================= */

function setWorkspaceTab(
    button,
    panel
) {

    document
        .querySelectorAll(".top-tab")
        .forEach(
            function (tab) {

                tab.classList.remove(
                    "active"
                );

            }
        );


    button.classList.add(
        "active"
    );


    const tabs =
        document.querySelectorAll(
            ".editor-tab"
        );


    if (panel === "editor") {

        openPanel(
            "content",
            tabs[0]
        );

    }


    if (panel === "design") {

        openPanel(
            "design",
            tabs[1]
        );

    }


    if (panel === "sections") {

        openPanel(
            "sections",
            tabs[2]
        );

    }

}


/* =========================================================
   VALUE
========================================================= */

function valueOf(
    id,
    fallback
) {

    const element =
        document.getElementById(id);


    if (!element) {

        return fallback || "";

    }


    return (
        element.value.trim() ||
        fallback ||
        ""
    );

}


/* =========================================================
   ESCAPE HTML
========================================================= */

function escapeHTML(
    value
) {

    return String(value)

        .replace(
            /&/g,
            "&amp;"
        )

        .replace(
            /</g,
            "&lt;"
        )

        .replace(
            />/g,
            "&gt;"
        )

        .replace(
            /"/g,
            "&quot;"
        )

        .replace(
            /'/g,
            "&#039;"
        );

}


/* =========================================================
   UPDATE EVERYTHING
========================================================= */

function updatePreview() {

    updatePersonal();

    updateSummary();

    updateExperience();

    updateEducation();

    updateProjects();

    updateSkills();

    updateSimpleFields();

    applyTemplateStyles();

}


/* =========================================================
   PERSONAL
========================================================= */

function updatePersonal() {

    const name =
        valueOf(
            "fullName",
            "Your Name"
        );


    const email =
        valueOf(
            "email",
            "email@example.com"
        );


    const phone =
        valueOf(
            "phone",
            "Phone"
        );


    const location =
        valueOf(
            "location",
            "Location"
        );


    document.getElementById(
        "previewName"
    ).textContent = name;


    document.getElementById(
        "rightPreviewName"
    ).textContent = name;


    const contactHTML =

        "<span>" +
            escapeHTML(email) +
        "</span>" +

        "<span>•</span>" +

        "<span>" +
            escapeHTML(phone) +
        "</span>" +

        "<span>•</span>" +

        "<span>" +
            escapeHTML(location) +
        "</span>";


    document.getElementById(
        "previewContact"
    ).innerHTML =
        contactHTML;


    document.getElementById(
        "rightPreviewContact"
    ).innerHTML =
        contactHTML;

}


/* =========================================================
   SUMMARY
========================================================= */

function updateSummary() {

    const summary =
        valueOf(
            "summary",
            "Your professional summary will appear here."
        );


    document.getElementById(
        "previewSummary"
    ).textContent =
        summary;


    document.getElementById(
        "rightPreviewSummary"
    ).textContent =
        summary;

}


/* =========================================================
   EXPERIENCE
========================================================= */

function updateExperience() {

    const cards =
        document.querySelectorAll(
            "#experienceContainer .entry-card"
        );


    let html = "";


    cards.forEach(
        function (card) {

            const role =
                card.querySelector(
                    ".exp-role"
                )?.value.trim();


            const company =
                card.querySelector(
                    ".exp-company"
                )?.value.trim();


            const start =
                card.querySelector(
                    ".exp-start"
                )?.value.trim();


            const end =
                card.querySelector(
                    ".exp-end"
                )?.value.trim();


            const description =
                card.querySelector(
                    ".exp-description"
                )?.value.trim();


            if (
                role ||
                company ||
                description
            ) {

                let dates = "";


                if (start || end) {

                    dates =
                        escapeHTML(
                            start || ""
                        ) +

                        " — " +

                        escapeHTML(
                            end || ""
                        );

                }


                html +=

                    '<div class="paper-entry">' +

                        '<div class="paper-entry-head">' +

                            '<span class="paper-entry-title">' +

                                escapeHTML(
                                    role ||
                                    "Position"
                                ) +

                            '</span>' +

                            '<span class="paper-entry-date">' +

                                dates +

                            '</span>' +

                        '</div>' +

                        '<div class="paper-entry-sub">' +

                            escapeHTML(
                                company ||
                                "Company"
                            ) +

                        '</div>' +

                        '<div class="paper-entry-description">' +

                            escapeHTML(
                                description ||
                                "Describe your responsibilities and achievements."
                            ) +

                        '</div>' +

                    '</div>';

            }

        }
    );


    if (!html) {

        html =

            '<div class="paper-entry">' +

                '<div class="paper-entry-title">' +
                    'Your experience' +
                '</div>' +

                '<div class="paper-entry-sub">' +
                    'Company Name' +
                '</div>' +

                '<div class="paper-entry-description">' +
                    'Your professional experience will appear here.' +
                '</div>' +

            '</div>';

    }


    document.getElementById(
        "previewExperience"
    ).innerHTML =
        html;


    document.getElementById(
        "rightPreviewExperience"
    ).innerHTML =
        html;

}


/* =========================================================
   EDUCATION
========================================================= */

function updateEducation() {

    const cards =
        document.querySelectorAll(
            "#educationContainer .entry-card"
        );


    let html = "";


    cards.forEach(
        function (card) {

            const degree =
                card.querySelector(
                    ".edu-degree"
                )?.value.trim();


            const school =
                card.querySelector(
                    ".edu-school"
                )?.value.trim();


            const start =
                card.querySelector(
                    ".edu-start"
                )?.value.trim();


            const end =
                card.querySelector(
                    ".edu-end"
                )?.value.trim();


            if (degree || school) {

                html +=

                    '<div class="paper-entry">' +

                        '<div class="paper-entry-head">' +

                            '<span class="paper-entry-title">' +

                                escapeHTML(
                                    degree ||
                                    "Degree"
                                ) +

                            '</span>' +

                            '<span class="paper-entry-date">' +

                                escapeHTML(
                                    start || ""
                                ) +

                                (
                                    start || end
                                        ? " — "
                                        : ""
                                ) +

                                escapeHTML(
                                    end || ""
                                ) +

                            '</span>' +

                        '</div>' +

                        '<div class="paper-entry-sub">' +

                            escapeHTML(
                                school ||
                                "Institution"
                            ) +

                        '</div>' +

                    '</div>';

            }

        }
    );


    if (!html) {

        html =

            '<div class="paper-entry">' +

                '<div class="paper-entry-title">' +
                    'Your Degree' +
                '</div>' +

                '<div class="paper-entry-sub">' +
                    'University / College' +
                '</div>' +

            '</div>';

    }


    document.getElementById(
        "previewEducation"
    ).innerHTML =
        html;


    document.getElementById(
        "rightPreviewEducation"
    ).innerHTML =
        html;

}


/* =========================================================
   PROJECTS
========================================================= */

function updateProjects() {

    const cards =
        document.querySelectorAll(
            "#projectsContainer .entry-card"
        );


    let html = "";


    cards.forEach(
        function (card) {

            const name =
                card.querySelector(
                    ".project-name"
                )?.value.trim();


            const tech =
                card.querySelector(
                    ".project-tech"
                )?.value.trim();


            const description =
                card.querySelector(
                    ".project-description"
                )?.value.trim();


            if (name || description) {

                html +=

                    '<div class="paper-entry">' +

                        '<div class="paper-entry-title">' +

                            escapeHTML(
                                name ||
                                "Project"
                            ) +

                        '</div>' +

                        '<div class="paper-entry-sub">' +

                            escapeHTML(
                                tech ||
                                "Technologies"
                            ) +

                        '</div>' +

                        '<div class="paper-entry-description">' +

                            escapeHTML(
                                description ||
                                "Describe your project."
                            ) +

                        '</div>' +

                    '</div>';

            }

        }
    );


    if (!html) {

        html =

            '<div class="paper-entry">' +

                '<div class="paper-entry-title">' +
                    'Your project' +
                '</div>' +

                '<div class="paper-entry-sub">' +
                    'Technologies' +
                '</div>' +

                '<div class="paper-entry-description">' +
                    'Your project description will appear here.' +
                '</div>' +

            '</div>';

    }


    document.getElementById(
        "previewProjects"
    ).innerHTML =
        html;


    document.getElementById(
        "rightPreviewProjects"
    ).innerHTML =
        html;

}


/* =========================================================
   SKILLS
========================================================= */

function updateSkills() {

    const skills =
        valueOf(
            "skills",
            "Java,SQL,HTML,CSS"
        );


    const list =
        skills
            .split(",")
            .map(
                function (item) {
                    return item.trim();
                }
            )
            .filter(
                function (item) {
                    return item.length > 0;
                }
            );


    let html = "";


    list.forEach(
        function (skill) {

            html +=

                '<span class="paper-skill">' +

                    escapeHTML(
                        skill
                    ) +

                '</span>';

        }
    );


    document.getElementById(
        "previewSkills"
    ).innerHTML =
        html;


    document.getElementById(
        "rightPreviewSkills"
    ).innerHTML =
        html;

}


/* =========================================================
   SIMPLE FIELDS
========================================================= */

function updateSimpleFields() {

    const fields = [

        [
            "certifications",
            "previewCertifications",
            "Certifications will appear here."
        ],

        [
            "languages",
            "previewLanguages",
            "English • Hindi • Marathi"
        ],

        [
            "achievements",
            "previewAchievements",
            "Your achievements will appear here."
        ],

        [
            "interests",
            "previewInterests",
            "Your interests will appear here."
        ]

    ];


    fields.forEach(
        function (item) {

            const value =
                valueOf(
                    item[0],
                    item[2]
                );


            const element =
                document.getElementById(
                    item[1]
                );


            if (element) {

                element.textContent =
                    value;

            }

        }
    );

}


/* =========================================================
   ADD EXPERIENCE
========================================================= */

function addExperience() {

    const container =
        document.getElementById(
            "experienceContainer"
        );


    const number =
        container.children.length + 1;


    const card =
        document.createElement(
            "div"
        );


    card.className =
        "entry-card";


    card.innerHTML =

        '<div class="entry-card-head">' +

            '<span class="entry-card-title">' +
                'Experience ' +
                number +
            '</span>' +

            '<button ' +
                'class="remove-entry" ' +
                'onclick="removeEntry(this)">' +
                '×' +
            '</button>' +

        '</div>' +

        '<div class="field">' +

            '<label>JOB TITLE</label>' +

            '<input ' +
                'class="exp-role" ' +
                'placeholder="Software Developer" ' +
                'oninput="updatePreview()">' +

        '</div>' +

        '<div class="field">' +

            '<label>COMPANY</label>' +

            '<input ' +
                'class="exp-company" ' +
                'placeholder="Company name" ' +
                'oninput="updatePreview()">' +

        '</div>' +

        '<div class="two-fields">' +

            '<div class="field">' +

                '<label>START</label>' +

                '<input ' +
                    'class="exp-start" ' +
                    'placeholder="Jan 2025" ' +
                    'oninput="updatePreview()">' +

            '</div>' +

            '<div class="field">' +

                '<label>END</label>' +

                '<input ' +
                    'class="exp-end" ' +
                    'placeholder="Present" ' +
                    'oninput="updatePreview()">' +

            '</div>' +

        '</div>' +

        '<div class="field">' +

            '<label>DESCRIPTION</label>' +

            '<textarea ' +
                'class="exp-description" ' +
                'placeholder="Describe your impact..." ' +
                'oninput="updatePreview()"></textarea>' +

        '</div>';


    container.appendChild(card);

    updatePreview();

}


/* =========================================================
   ADD EDUCATION
========================================================= */

function addEducation() {

    const container =
        document.getElementById(
            "educationContainer"
        );


    const number =
        container.children.length + 1;


    const card =
        document.createElement(
            "div"
        );


    card.className =
        "entry-card";


    card.innerHTML =

        '<div class="entry-card-head">' +

            '<span class="entry-card-title">' +
                'Education ' +
                number +
            '</span>' +

            '<button ' +
                'class="remove-entry" ' +
                'onclick="removeEntry(this)">' +
                '×' +
            '</button>' +

        '</div>' +

        '<div class="field">' +

            '<label>DEGREE</label>' +

            '<input ' +
                'class="edu-degree" ' +
                'placeholder="B.E. Information Technology" ' +
                'oninput="updatePreview()">' +

        '</div>' +

        '<div class="field">' +

            '<label>INSTITUTION</label>' +

            '<input ' +
                'class="edu-school" ' +
                'placeholder="University / College" ' +
                'oninput="updatePreview()">' +

        '</div>' +

        '<div class="two-fields">' +

            '<div class="field">' +

                '<label>START</label>' +

                '<input ' +
                    'class="edu-start" ' +
                    'placeholder="2024" ' +
                    'oninput="updatePreview()">' +

            '</div>' +

            '<div class="field">' +

                '<label>END</label>' +

                '<input ' +
                    'class="edu-end" ' +
                    'placeholder="2028" ' +
                    'oninput="updatePreview()">' +

            '</div>' +

        '</div>';


    container.appendChild(card);

    updatePreview();

}


/* =========================================================
   ADD PROJECT
========================================================= */

function addProject() {

    const container =
        document.getElementById(
            "projectsContainer"
        );


    const number =
        container.children.length + 1;


    const card =
        document.createElement(
            "div"
        );


    card.className =
        "entry-card";


    card.innerHTML =

        '<div class="entry-card-head">' +

            '<span class="entry-card-title">' +
                'Project ' +
                number +
            '</span>' +

            '<button ' +
                'class="remove-entry" ' +
                'onclick="removeEntry(this)">' +
                '×' +
            '</button>' +

        '</div>' +

        '<div class="field">' +

            '<label>PROJECT NAME</label>' +

            '<input ' +
                'class="project-name" ' +
                'placeholder="SmartResume" ' +
                'oninput="updatePreview()">' +

        '</div>' +

        '<div class="field">' +

            '<label>TECHNOLOGIES</label>' +

            '<input ' +
                'class="project-tech" ' +
                'placeholder="Java, JSP, Servlets, MySQL" ' +
                'oninput="updatePreview()">' +

        '</div>' +

        '<div class="field">' +

            '<label>DESCRIPTION</label>' +

            '<textarea ' +
                'class="project-description" ' +
                'placeholder="Describe your project..." ' +
                'oninput="updatePreview()"></textarea>' +

        '</div>';


    container.appendChild(card);

    updatePreview();

}


/* =========================================================
   REMOVE ENTRY
========================================================= */

function removeEntry(button) {

    const card =
        button.closest(
            ".entry-card"
        );


    if (!card) return;


    card.remove();

    updatePreview();

}


/* =========================================================
   TEMPLATE SELECTION
========================================================= */

function selectTemplate(
    element,
    template
) {

    document
        .querySelectorAll(
            ".template-option"
        )
        .forEach(
            function (option) {

                option.classList.remove(
                    "selected"
                );

            }
        );


    element.classList.add(
        "selected"
    );


    applyTemplate(
        template
    );

}


/* =========================================================
   APPLY TEMPLATE
========================================================= */

function applyTemplate(
    template
) {

    currentTemplate =
        template;


    const paper =
        document.getElementById(
            "paper"
        );


    const preview =
        document.getElementById(
            "previewPaper"
        );


    const classes = [

        "template-modern",
        "template-sidebar",
        "template-classic",
        "template-minimal",
        "template-executive",
        "template-creative",
        "template-developer",
        "template-corporate"

    ];


    classes.forEach(
        function (className) {

            paper.classList.remove(
                className
            );

            preview.classList.remove(
                className
            );

        }
    );


    paper.classList.add(
        "template-" +
        template
    );


    preview.classList.add(
        "template-" +
        template
    );


    applyTemplateStyles();

}


/* =========================================================
   TEMPLATE STYLES
========================================================= */

function applyTemplateStyles() {

    const papers =
        document.querySelectorAll(
            "#paper,#previewPaper"
        );


    papers.forEach(
        function (paper) {

            paper.style.setProperty(
                "--accent",
                currentColor
            );


            const header =
                paper.querySelector(
                    ".paper-header"
                );


            const name =
                paper.querySelector(
                    ".paper-name"
                );


            const role =
                paper.querySelector(
                    ".paper-role"
                );


            const titles =
                paper.querySelectorAll(
                    ".paper-section-title"
                );


            const skills =
                paper.querySelectorAll(
                    ".paper-skill"
                );


            /* RESET */

            paper.style.fontFamily =
                currentFont;


            name.style.fontSize =
                currentFontSize +
                "px";


            paper.style.padding =
                currentSpacing +
                "px";


            /* MODERN */

            if (
                currentTemplate ===
                "modern"
            ) {

                paper.style.padding =
                    currentSpacing +
                    "px " +
                    (currentSpacing + 4) +
                    "px";


                header.style.borderBottom =
                    "2px solid " +
                    currentColor;


                name.style.fontWeight =
                    "800";


                name.style.letterSpacing =
                    "-1.5px";


                role.style.color =
                    "#666";


                titles.forEach(
                    function (title) {

                        title.style.color =
                            currentColor;

                        title.style.borderLeft =
                            "none";

                        title.style.paddingLeft =
                            "0";

                    }
                );


                skills.forEach(
                    function (skill) {

                        skill.style.background =
                            hexToRgba(
                                currentColor,
                                .09
                            );

                        skill.style.border =
                            "none";

                    }
                );

            }


            /* SIDEBAR */

            if (
                currentTemplate ===
                "sidebar"
            ) {

                paper.style.paddingLeft =
                    "112px";


                header.style.borderBottom =
                    "none";


                name.style.color =
                    currentColor;


                titles.forEach(
                    function (title) {

                        title.style.color =
                            currentColor;

                    }
                );

            }


            /* CLASSIC */

            if (
                currentTemplate ===
                "classic"
            ) {

                paper.style.fontFamily =
                    "Georgia,serif";


                paper.style.padding =
                    "52px 65px";


                header.style.borderBottom =
                    "1px solid #222";


                name.style.fontFamily =
                    "Georgia,serif";


                name.style.fontWeight =
                    "700";


                role.style.fontFamily =
                    "Georgia,serif";


                role.style.fontStyle =
                    "italic";


                titles.forEach(
                    function (title) {

                        title.style.color =
                            "#222";

                        title.style.borderBottom =
                            "1px solid " +
                            currentColor;

                        title.style.paddingBottom =
                            "5px";

                    }
                );

            }


            /* MINIMAL */

            if (
                currentTemplate ===
                "minimal"
            ) {

                paper.style.padding =
                    "72px";


                header.style.borderBottom =
                    "none";


                name.style.fontWeight =
                    "500";


                name.style.letterSpacing =
                    "-1px";


                titles.forEach(
                    function (title) {

                        title.style.color =
                            "#222";

                        title.style.fontSize =
                            "9px";

                        title.style.letterSpacing =
                            "2px";

                    }
                );

            }


            /* EXECUTIVE */

            if (
                currentTemplate ===
                "executive"
            ) {

                paper.style.fontFamily =
                    "Georgia,serif";


                paper.style.padding =
                    "55px 68px";


                header.style.borderBottom =
                    "1px solid #222";


                name.style.fontFamily =
                    "Georgia,serif";


                name.style.fontWeight =
                    "700";


                role.style.fontFamily =
                    "Georgia,serif";


                role.style.fontStyle =
                    "italic";


                titles.forEach(
                    function (title) {

                        title.style.fontFamily =
                            "Georgia,serif";

                        title.style.color =
                            "#222";

                        title.style.borderBottom =
                            "1px solid " +
                            currentColor;

                        title.style.paddingBottom =
                            "5px";

                    }
                );

            }


            /* CREATIVE */

            if (
                currentTemplate ===
                "creative"
            ) {

                paper.style.padding =
                    "52px 60px";


                header.style.borderBottom =
                    "none";


                name.style.color =
                    currentColor;


                name.style.fontWeight =
                    "900";


                titles.forEach(
                    function (title) {

                        title.style.color =
                            currentColor;

                        title.style.borderLeft =
                            "4px solid " +
                            currentColor;

                        title.style.paddingLeft =
                            "8px";

                    }
                );


                skills.forEach(
                    function (skill) {

                        skill.style.background =
                            currentColor;

                        skill.style.color =
                            "#fff";

                        skill.style.borderRadius =
                            "20px";

                    }
                );

            }


            /* DEVELOPER */

            if (
                currentTemplate ===
                "developer"
            ) {

                paper.style.fontFamily =
                    "'Courier New',monospace";


                paper.style.padding =
                    "48px 58px";


                header.style.borderBottom =
                    "2px dashed " +
                    currentColor;


                name.style.fontFamily =
                    "'Courier New',monospace";


                name.style.fontWeight =
                    "700";


                titles.forEach(
                    function (title) {

                        title.style.fontFamily =
                            "'Courier New',monospace";

                        title.style.color =
                            currentColor;

                    }
                );


                skills.forEach(
                    function (skill) {

                        skill.style.fontFamily =
                            "'Courier New',monospace";

                        skill.style.background =
                            "#f2f2f2";

                        skill.style.border =
                            "1px solid #ccc";

                    }
                );

            }


            /* CORPORATE */

            if (
                currentTemplate ===
                "corporate"
            ) {

                paper.style.padding =
                    "52px 60px";


                header.style.background =
                    currentColor;


                header.style.padding =
                    "25px";


                header.style.borderBottom =
                    "none";


                name.style.color =
                    "#fff";


                role.style.color =
                    "rgba(255,255,255,.82)";


                titles.forEach(
                    function (title) {

                        title.style.color =
                            currentColor;

                        title.style.borderBottom =
                            "1px solid #ddd";

                        title.style.paddingBottom =
                            "6px";

                    }
                );


                skills.forEach(
                    function (skill) {

                        skill.style.background =
                            hexToRgba(
                                currentColor,
                                .1
                            );

                        skill.style.color =
                            "#333";

                    }
                );

            }

        }
    );

}


/* =========================================================
   COLOR
========================================================= */

function selectColor(
    element
) {

    document
        .querySelectorAll(
            ".color-option"
        )
        .forEach(
            function (option) {

                option.classList.remove(
                    "selected"
                );

            }
        );


    element.classList.add(
        "selected"
    );


    applyColor(
        element.dataset.color
    );

}


function applyColor(
    color
) {

    currentColor =
        color;


    document
        .querySelectorAll(
            "#paper,#previewPaper"
        )
        .forEach(
            function (paper) {

                paper.style.setProperty(
                    "--accent",
                    color
                );

            }
        );


    applyTemplateStyles();

}


/* =========================================================
   HEX TO RGBA
========================================================= */

function hexToRgba(
    hex,
    alpha
) {

    const clean =
        hex.replace(
            "#",
            ""
        );


    const number =
        parseInt(
            clean,
            16
        );


    const r =
        (number >> 16) & 255;


    const g =
        (number >> 8) & 255;


    const b =
        number & 255;


    return (
        "rgba(" +
        r +
        "," +
        g +
        "," +
        b +
        "," +
        alpha +
        ")"
    );

}


/* =========================================================
   FONT
========================================================= */

function changeFont(
    font
) {

    currentFont =
        font;


    applyTemplateStyles();

}


/* =========================================================
   FONT SIZE
========================================================= */

function changeFontSize(
    value
) {

    currentFontSize =
        Number(value);


    document.getElementById(
        "fontSizeValue"
    ).textContent =
        value;


    document
        .querySelectorAll(
            ".paper-name"
        )
        .forEach(
            function (name) {

                name.style.fontSize =
                    value +
                    "px";

            }
        );

}


/* =========================================================
   SPACING
========================================================= */

function changeSpacing(
    value
) {

    currentSpacing =
        Number(value);


    document.getElementById(
        "spacingValue"
    ).textContent =
        value;


    applyTemplateStyles();

}


/* =========================================================
   SECTION TOGGLE
========================================================= */

function toggleSection(
    toggle,
    sectionId
) {

    toggle.classList.toggle(
        "on"
    );


    const section =
        document.getElementById(
            sectionId
        );


    if (!section) return;


    section.style.display =
        toggle.classList.contains(
            "on"
        )
            ? ""
            : "none";

}


/* =========================================================
   ZOOM
========================================================= */

function applyZoom() {

    const wrapper =
        document.getElementById(
            "paperWrapper"
        );


    wrapper.style.transform =
        "scale(" +
        currentZoom +
        ")";


    const percentage =
        Math.round(
            currentZoom * 100
        ) +
        "%";


    document.getElementById(
        "zoomValue"
    ).textContent =
        percentage;


    document.getElementById(
        "centerZoom"
    ).textContent =
        percentage;

}


function zoomIn() {

    currentZoom =
        Math.min(
            1,
            currentZoom + .05
        );


    applyZoom();

}


function zoomOut() {

    currentZoom =
        Math.max(
            .45,
            currentZoom - .05
        );


    applyZoom();

}


function resetZoom() {

    currentZoom =
        .70;


    applyZoom();

}


/* =========================================================
   RIGHT PREVIEW ZOOM
========================================================= */

function applyPreviewZoom() {

    const paper =
        document.getElementById(
            "previewPaper"
        );


    paper.style.transform =
        "scale(" +
        currentPreviewZoom +
        ")";

}


function zoomInPreview() {

    currentPreviewZoom =
        Math.min(
            1,
            currentPreviewZoom + .05
        );


    applyPreviewZoom();

}


function zoomOutPreview() {

    currentPreviewZoom =
        Math.max(
            .45,
            currentPreviewZoom - .05
        );


    applyPreviewZoom();

}


/* =========================================================
   FULL PREVIEW
========================================================= */

function toggleFullPreview() {

    const preview =
        document.querySelector(
            ".preview-panel"
        );


    const editor =
        document.querySelector(
            ".editor-panel"
        );


    if (
        preview.style.position ===
        "fixed"
    ) {

        preview.style.position = "";

        preview.style.left = "";

        preview.style.top = "";

        preview.style.right = "";

        preview.style.bottom = "";

        preview.style.zIndex = "";

        editor.style.display = "";

    }

    else {

        preview.style.position =
            "fixed";

        preview.style.left =
            "0";

        preview.style.top =
            "68px";

        preview.style.right =
            "0";

        preview.style.bottom =
            "0";

        preview.style.zIndex =
            "500";

        editor.style.display =
            "none";

    }

}


/* =========================================================
   SAVE UI
========================================================= */

let currentResumeId = <%= loadedResumeId %>;
let saveInProgress = false;

function collectExperience() {
    return Array.from(document.querySelectorAll("#experienceContainer .entry-card")).map(function(card) {
        return {
            role: card.querySelector(".exp-role")?.value.trim() || "",
            company: card.querySelector(".exp-company")?.value.trim() || "",
            start: card.querySelector(".exp-start")?.value.trim() || "",
            end: card.querySelector(".exp-end")?.value.trim() || "",
            description: card.querySelector(".exp-description")?.value.trim() || ""
        };
    }).filter(function(item) {
        return item.role || item.company || item.description;
    });
}

function collectEducation() {
    return Array.from(document.querySelectorAll("#educationContainer .entry-card")).map(function(card) {
        return {
            degree: card.querySelector(".edu-degree")?.value.trim() || "",
            school: card.querySelector(".edu-school")?.value.trim() || "",
            start: card.querySelector(".edu-start")?.value.trim() || "",
            end: card.querySelector(".edu-end")?.value.trim() || ""
        };
    }).filter(function(item) {
        return item.degree || item.school;
    });
}

function collectProjects() {
    return Array.from(document.querySelectorAll("#projectsContainer .entry-card")).map(function(card) {
        return {
            name: card.querySelector(".project-name")?.value.trim() || "",
            tech: card.querySelector(".project-tech")?.value.trim() || "",
            description: card.querySelector(".project-description")?.value.trim() || ""
        };
    }).filter(function(item) {
        return item.name || item.description;
    });
}

async function saveResume(silent) {
    if (saveInProgress) return;

    const status = document.getElementById("saveStatus");
    const saveButton = document.querySelector('.top-button.dark[onclick*="saveResume"]');
    if (!silent) {
        status.textContent = "Saving...";
        if (saveButton) { saveButton.disabled = true; saveButton.textContent = "Saving…"; }
    }

    saveInProgress = true;

    try {
        const data = new FormData();

        data.append("resumeId", String(currentResumeId || 0));
        data.append("resumeTitle", valueOf("resumeTitle", "My Resume"));
        data.append("fullName", valueOf("fullName", ""));
        data.append("email", valueOf("email", ""));
        data.append("phone", valueOf("phone", ""));
        data.append("location", valueOf("location", ""));
        data.append("linkedin", valueOf("linkedin", ""));
        data.append("github", valueOf("github", ""));
        data.append("summary", valueOf("summary", ""));
        data.append("education", JSON.stringify(collectEducation()));
        data.append("skills", valueOf("skills", ""));
        data.append("projects", JSON.stringify(collectProjects()));
        data.append("experience", JSON.stringify(collectExperience()));
        data.append("certifications", valueOf("certifications", ""));
        data.append("languages", valueOf("languages", ""));
        data.append("achievements", valueOf("achievements", ""));
        data.append("interests", valueOf("interests", ""));
        data.append("template", currentTemplate);
        data.append("themeColor", currentColor);

        const photoInput = document.getElementById("profilePhotoInput");
        if (photoInput && photoInput.files && photoInput.files.length > 0) {
            data.append("profilePhoto", photoInput.files[0]);
        }

        const controller = new AbortController();
        const timeout = setTimeout(() => controller.abort(), 15000);

        const response = await fetch("<%= contextPath %>/resume-builder", {
            method: "POST",
            body: data,
            credentials: "same-origin",
            headers: { "X-Requested-With": "XMLHttpRequest" },
            signal: controller.signal
        });

        clearTimeout(timeout);

        const finalUrl = new URL(response.url, window.location.origin);
        if (finalUrl.pathname.endsWith("/login") || finalUrl.pathname.endsWith("/login.jsp")) {
            throw new Error("Your session expired. Please login again.");
        }
        if (!response.ok) throw new Error("Server returned " + response.status);

        const savedId = finalUrl.searchParams.get("resumeId");
        if (savedId) currentResumeId = Number(savedId);

        status.textContent = "Saved just now";
        showStudioToast("Resume saved successfully", "success");
    } catch (error) {
        console.error("SmartResume save error:", error);
        status.textContent = "Save failed";
        showStudioToast(error.name === "AbortError" ? "Save timed out — check Tomcat" : (error.message || "Could not save resume"), "error");
    } finally {
        saveInProgress = false;
        if (saveButton) { saveButton.disabled = false; saveButton.textContent = "Save"; }
    }
}

function showStudioToast(message, type) {
    const toast = document.getElementById("studioToast");
    if (!toast) return;
    toast.textContent = message;
    toast.className = "studio-toast show " + (type || "");
    clearTimeout(window.__studioToastTimer);
    window.__studioToastTimer = setTimeout(() => {
        toast.classList.remove("show");
    }, 3000);
}

function handleProfilePhoto(input) {
    const file = input && input.files ? input.files[0] : null;
    if (!file) return;

    if (!/^image\/(jpeg|png|webp)$/.test(file.type)) {
        showStudioToast("Please choose a JPG, PNG or WEBP image", "error");
        input.value = "";
        return;
    }
    if (file.size > 5 * 1024 * 1024) {
        showStudioToast("Profile photo must be under 5 MB", "error");
        input.value = "";
        return;
    }

    const reader = new FileReader();
    reader.onload = function (event) {
        const src = event.target.result;
        const holder = document.getElementById("studioPhotoPreview");
        if (holder) holder.innerHTML = '<img src="' + src + '" alt="Profile photo">';

        document.querySelectorAll(".paper-photo").forEach(function (photo) {
            photo.innerHTML = '<img src="' + src + '" alt="Profile photo">';
        });

        showStudioToast("Photo ready — save the resume to keep it", "success");
        markUnsaved();
        updatePreview();
    };
    reader.readAsDataURL(file);
}

function markUnsaved() {
    const status = document.getElementById("saveStatus");
    if (status) status.textContent = "Unsaved changes";
}


/* =========================================================
   AUTOSAVE INDICATOR
========================================================= */

let autosaveTimer;


document.addEventListener(
    "input",
    function () {

        clearTimeout(
            autosaveTimer
        );


        const status =
            document.getElementById(
                "saveStatus"
            );


        if (!status) return;


        status.textContent =
            "Unsaved changes";


        autosaveTimer =
            setTimeout(
                function () {
                    saveResume(true);
                },
                1500
            );

    }
);


/* =========================================================
   CTRL + S
========================================================= */

document.addEventListener(
    "keydown",
    function (event) {

        if (
            (
                event.ctrlKey ||
                event.metaKey
            ) &&
            event.key.toLowerCase() ===
            "s"
        ) {

            event.preventDefault();

            saveResume();

        }

    }
);

</script>

</body>

</html>