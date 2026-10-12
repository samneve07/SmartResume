<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.smartresume.dao.ResumeDAO.ResumeData" %>

<%!
    private String js(String value) {
        if (value == null) return "";
        return value
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\r", "\\r")
                .replace("\n", "\\n")
                .replace("</", "<\\/");
    }
%>

<%
    String contextPath = request.getContextPath();

    String fullName = (String) session.getAttribute("fullName");
    String email = (String) session.getAttribute("email");

    if (fullName == null) fullName = "";
    if (email == null) email = "";

    ResumeData savedResume =
            (ResumeData) request.getAttribute("resumeData");

    if (savedResume != null) {
        fullName = savedResume.getFullName() == null
                ? ""
                : savedResume.getFullName();

        email = savedResume.getEmail() == null
                ? ""
                : savedResume.getEmail();
    }

    String selectedTemplate =
            (String) request.getAttribute("selectedTemplate");

    // Gallery passes the chosen template in the URL query string.
    // Prefer an explicit request attribute, then fall back to the query parameter.
    if (selectedTemplate == null || selectedTemplate.isBlank()) {
        selectedTemplate = request.getParameter("template");
    }

    // Accept only the 12 supported gallery template IDs.
    if (selectedTemplate == null ||
            !selectedTemplate.matches("template-(0[1-9]|1[0-2])")) {
        selectedTemplate = "template-01";
    }

    String selectedThemeColor =
            savedResume != null &&
            savedResume.getThemeColor() != null &&
            !savedResume.getThemeColor().isBlank()
                    ? savedResume.getThemeColor()
                    : "#111111";

    String selectedTitle =
            savedResume != null &&
            savedResume.getResumeTitle() != null &&
            !savedResume.getResumeTitle().isBlank()
                    ? savedResume.getResumeTitle()
                    : "My Resume";

    String savedPhoto =
            savedResume != null &&
            savedResume.getProfilePhoto() != null
                    ? savedResume.getProfilePhoto()
                    : "";

    String avatarLetter =
            fullName.isEmpty()
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
    flex: 1 1 0;
    min-height: 0;
    min-width: 0;
    height: 0;

    overflow-y: scroll;
    overflow-x: hidden;

    overscroll-behavior-y: contain;
    -webkit-overflow-scrolling: touch;

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

.photo-upload-row {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 12px;
    border: 1px solid #e5e5e5;
    border-radius: 12px;
    background: #fafafa;
}

.photo-upload-preview {
    width: 58px;
    height: 58px;
    flex: 0 0 58px;
    border-radius: 50%;
    border: 1px dashed #bdbdbd;
    background: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    color: #888;
    font-size: 20px;
}

.photo-upload-preview img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: none;
}

.photo-upload-actions {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 7px;
}

.photo-upload-button,
.photo-remove-button {
    border: 1px solid #ddd;
    background: #fff;
    border-radius: 8px;
    padding: 8px 11px;
    cursor: pointer;
    font-size: 11px;
    font-weight: 700;
}

.photo-upload-button {
    background: #111;
    color: #fff;
    border-color: #111;
}

.photo-upload-help {
    width: 100%;
    font-size: 9px;
    color: #888;
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

/* NEW 12 TEMPLATE BASE STYLES */

.paper[class*="template-template-"],
.preview-paper[class*="template-template-"] {
    font-family: Arial, sans-serif;
    color: #222;
    line-height: 1.35;
}

.paper.template-template-01,
.preview-paper.template-template-01 {
    padding: 48px 55px;
}

.paper.template-template-02,
.preview-paper.template-template-02 {
    padding: 45px 50px;
    border-top: 8px solid var(--accent);
}

.paper.template-template-03,
.preview-paper.template-template-03 {
    padding: 55px 62px;
    font-family: Georgia, serif;
}

.paper.template-template-04,
.preview-paper.template-template-04 {
    padding: 60px;
    font-family: Arial, sans-serif;
}

.paper.template-template-05,
.preview-paper.template-template-05 {
    padding: 45px 55px;
    border-top: 5px solid var(--accent);
}

.paper.template-template-06,
.preview-paper.template-template-06 {
    padding: 50px 58px;
    font-family: "Trebuchet MS", sans-serif;
}

.paper.template-template-07,
.preview-paper.template-template-07 {
    padding: 45px 52px;
    font-family: "Courier New", monospace;
}

.paper.template-template-08,
.preview-paper.template-template-08 {
    padding: 48px 55px;
    border-left: 12px solid var(--accent);
}

.paper.template-template-09,
.preview-paper.template-template-09 {
    padding: 55px 60px;
    font-family: Georgia, serif;
}

.paper.template-template-10,
.preview-paper.template-template-10 {
    padding: 45px 55px;
    border-top: 3px double var(--accent);
}

.paper.template-template-11,
.preview-paper.template-template-11 {
    padding: 50px 58px;
    font-family: Arial, sans-serif;
}

.paper.template-template-12,
.preview-paper.template-template-12 {
    padding: 45px 55px;
    border-top: 10px solid var(--accent);
}

.paper[class*="template-template-"] .paper-section-title,
.preview-paper[class*="template-template-"] .paper-section-title {
    color: var(--accent);
    font-weight: 700;
    margin-bottom: 6px;
}


/* SMARTRESUME: 12 distinct template designs */
.template-option { height:132px; padding:8px 6px 20px; display:flex; flex-direction:column; align-items:center; justify-content:flex-start; gap:5px; }
.template-option > span { position:absolute; left:5px; right:5px; bottom:5px; font-size:6px; font-weight:900; letter-spacing:.25px; color:#666; text-align:center; }
.mini-paper { position:relative; flex:0 0 80px; }
.mini-paper b { display:block; width:75%; height:5px; margin:2px 0 5px; background:#222; border-radius:1px; }
.mini-paper i { display:block; width:90%; height:2px; margin:4px 0; background:#d5d5d5; }
.mini-paper i:nth-of-type(2) { width:70%; }
.mini-paper em { display:block; width:42%; height:4px; margin:8px 0 4px; background:#555; }
.mini-paper hr { border:0; border-top:1px solid #bbb; margin:6px 0; }
.mini-01 { padding:7px; border-top:3px solid #222; }
.mini-02 { padding:8px 6px; border-top:8px solid #2563eb; }
.mini-02 b { background:#2563eb; }
.mini-03 { padding:7px; font-family:Georgia,serif; }
.mini-03 b { height:7px; width:85%; }
.mini-03 hr { border-top:2px solid #333; }
.mini-04 { padding:12px 8px; }
.mini-04 b { height:3px; width:55%; background:#777; }
.mini-04 hr { border:0; margin:9px 0; }
.mini-05 { padding:7px; border-top:4px solid #0f766e; }
.mini-05 em { background:#0f766e; }
.mini-06 { padding:7px; border-left:5px solid #7c3aed; }
.mini-06 b { background:#7c3aed; height:7px; }
.mini-06 em { background:#7c3aed; }
.mini-07 { padding:7px; font-family:monospace; background:#f7f7f7; }
.mini-07 b { width:82%; background:#16a34a; }
.mini-07 hr { border-top:1px dashed #777; }
.mini-08 { padding:7px 5px 7px 13px; border-left:8px solid #1e293b; }
.mini-08 b { background:#1e293b; }
.mini-09 { padding:8px; font-family:Georgia,serif; }
.mini-09 b { height:4px; width:82%; }
.mini-09 em { height:2px; background:#333; }
.mini-10 { padding:7px; border-top:4px double #b45309; }
.mini-10 hr { border-top:3px double #b45309; }
.mini-10 em { background:#b45309; }
.mini-11 { padding:5px 6px; }
.mini-11 b { height:4px; margin-bottom:3px; }
.mini-11 i { margin:3px 0; height:2px; }
.mini-11 em { margin:5px 0 3px; }
.mini-12 { padding:8px 6px; border-top:10px solid #111; }
.mini-12 b { background:#111; height:6px; }
.paper.template-template-01, .preview-paper.template-template-01 { font-family:Arial,sans-serif; padding:48px 55px !important; }
.paper.template-template-01 .paper-header, .preview-paper.template-template-01 .paper-header { border-bottom:2px solid var(--accent) !important; }
.paper.template-template-02, .preview-paper.template-template-02 { padding:45px 50px !important; border-top:8px solid var(--accent); }
.paper.template-template-02 .paper-header, .preview-paper.template-template-02 .paper-header { background:var(--accent); padding:24px !important; border:0 !important; }
.paper.template-template-02 .paper-name, .preview-paper.template-template-02 .paper-name, .paper.template-template-02 .paper-role, .preview-paper.template-template-02 .paper-role { color:#fff !important; }
.paper.template-template-03, .preview-paper.template-template-03 { padding:55px 62px !important; font-family:Georgia,serif !important; }
.paper.template-template-03 .paper-name, .preview-paper.template-template-03 .paper-name { font-family:Georgia,serif !important; letter-spacing:-.5px !important; }
.paper.template-template-03 .paper-header, .preview-paper.template-template-03 .paper-header { border-bottom:1px solid #222 !important; }
.paper.template-template-04, .preview-paper.template-template-04 { padding:60px !important; }
.paper.template-template-04 .paper-header, .preview-paper.template-template-04 .paper-header { border:0 !important; }
.paper.template-template-04 .paper-name, .preview-paper.template-template-04 .paper-name { font-weight:400 !important; letter-spacing:-1px !important; }
.paper.template-template-05, .preview-paper.template-template-05 { padding:45px 55px !important; border-top:5px solid var(--accent); }
.paper.template-template-05 .paper-section-title, .preview-paper.template-template-05 .paper-section-title { border-bottom:1px solid #ddd; padding-bottom:5px; }
.paper.template-template-06, .preview-paper.template-template-06 { padding:50px 58px !important; font-family:"Trebuchet MS",sans-serif !important; }
.paper.template-template-06 .paper-header, .preview-paper.template-template-06 .paper-header { border:0 !important; }
.paper.template-template-06 .paper-name, .preview-paper.template-template-06 .paper-name { color:var(--accent) !important; font-weight:900 !important; }
.paper.template-template-06 .paper-section-title, .preview-paper.template-template-06 .paper-section-title { border-left:4px solid var(--accent); padding-left:8px; }
.paper.template-template-07, .preview-paper.template-template-07 { padding:45px 52px !important; font-family:"Courier New",monospace !important; }
.paper.template-template-07 .paper-header, .preview-paper.template-template-07 .paper-header { border-bottom:2px dashed var(--accent) !important; }
.paper.template-template-07 .paper-name, .preview-paper.template-template-07 .paper-name { font-family:"Courier New",monospace !important; }
.paper.template-template-07 .paper-skill, .preview-paper.template-template-07 .paper-skill { border:1px solid #bbb; border-radius:0; }
.paper.template-template-08, .preview-paper.template-template-08 { padding:48px 55px 48px 70px !important; border-left:12px solid var(--accent); }
.paper.template-template-08 .paper-header, .preview-paper.template-template-08 .paper-header { border:0 !important; }
.paper.template-template-08 .paper-section-title, .preview-paper.template-template-08 .paper-section-title { letter-spacing:1px; }
.paper.template-template-09, .preview-paper.template-template-09 { padding:55px 60px !important; font-family:Georgia,serif !important; }
.paper.template-template-09 .paper-header, .preview-paper.template-template-09 .paper-header { justify-content:center !important; text-align:center; border-bottom:3px double var(--accent) !important; }
.paper.template-template-09 .paper-photo, .preview-paper.template-template-09 .paper-photo { display:none; }
.paper.template-template-09 .paper-name, .preview-paper.template-template-09 .paper-name { font-family:Georgia,serif !important; }
.paper.template-template-10, .preview-paper.template-template-10 { padding:45px 55px !important; border-top:3px double var(--accent); }
.paper.template-template-10 .paper-header, .preview-paper.template-template-10 .paper-header { border-bottom:3px double var(--accent) !important; padding-bottom:18px; }
.paper.template-template-10 .paper-section-title, .preview-paper.template-template-10 .paper-section-title { border-bottom:1px solid var(--accent); padding-bottom:4px; }
.paper.template-template-11, .preview-paper.template-template-11 { padding:50px 58px !important; }
.paper.template-template-11 .paper-section, .preview-paper.template-template-11 .paper-section { margin-top:16px; }
.paper.template-template-11 .paper-entry, .preview-paper.template-template-11 .paper-entry { margin-bottom:9px; }
.paper.template-template-11 .paper-header, .preview-paper.template-template-11 .paper-header { padding-bottom:14px; }
.paper.template-template-11 .paper-name, .preview-paper.template-template-11 .paper-name { font-size:30px !important; letter-spacing:-.4px !important; }
.paper.template-template-12, .preview-paper.template-template-12 { padding:45px 55px !important; border-top:10px solid var(--accent); }
.paper.template-template-12 .paper-header, .preview-paper.template-template-12 .paper-header { border-bottom:0 !important; padding-bottom:12px; }
.paper.template-template-12 .paper-name, .preview-paper.template-template-12 .paper-name { color:var(--accent) !important; }


/* SMARTRESUME - ACTUAL GALLERY TEMPLATE LAYOUTS */
.paper[class*="template-template-"],
.preview-paper[class*="template-template-"] {
    box-sizing: border-box;
    background: #fff;
    color: #222;
}

/* 01 - Navy Wave: dark right sidebar */
.paper.template-template-01,
.preview-paper.template-template-01 {
    display: grid;
    grid-template-columns: 62% 38%;
    align-content: start;
}
.paper.template-template-01 .paper-header,
.preview-paper.template-template-01 .paper-header {
    display: contents;
}
.paper.template-template-01 .paper-header > div:first-child,
.preview-paper.template-template-01 .paper-header > div:first-child {
    grid-column: 2;
    grid-row: 1;
    background: #080f46;
    color: white;
    padding: 20px 12px;
}
.paper.template-template-01 .paper-photo,
.preview-paper.template-template-01 .paper-photo {
    grid-column: 1;
    grid-row: 1 / span 2;
}
.paper.template-template-01 .paper-contact,
.preview-paper.template-template-01 .paper-contact {
    grid-column: 1;
}
.paper.template-template-01 .paper-section,
.preview-paper.template-template-01 .paper-section {
    grid-column: 2;
}

/* 02 - Plum & Ivory: left sidebar */
.paper.template-template-02,
.preview-paper.template-template-02 {
    display: grid;
    grid-template-columns: 38% 62%;
    align-content: start;
    background: #f7f6e9;
    border-top: 0;
}
.paper.template-template-02 .paper-header,
.preview-paper.template-template-02 .paper-header {
    display: contents;
}
.paper.template-template-02 .paper-header > div:first-child,
.preview-paper.template-template-02 .paper-header > div:first-child {
    grid-column: 2;
    grid-row: 1;
    background: transparent;
    color: #171017;
    padding: 14px;
}
.paper.template-template-02 .paper-photo,
.preview-paper.template-template-02 .paper-photo {
    grid-column: 1;
    grid-row: 1;
    background: #2b1c28;
    min-height: 110px;
}
.paper.template-template-02 .paper-contact,
.preview-paper.template-template-02 .paper-contact,
.paper.template-template-02 #skillsSection,
.preview-paper.template-template-02 #skillsSection,
.paper.template-template-02 #educationSection,
.preview-paper.template-template-02 #educationSection,
.paper.template-template-02 #languagesSection,
.preview-paper.template-template-02 #languagesSection,
.paper.template-template-02 #interestsSection,
.preview-paper.template-template-02 #interestsSection {
    grid-column: 1;
    background: #2b1c28;
    color: white;
    padding: 8px;
}
.paper.template-template-02 .paper-section,
.preview-paper.template-template-02 .paper-section {
    grid-column: 2;
    padding: 8px 12px;
}

/* 03 - Orange Geometry */
.paper.template-template-03,
.preview-paper.template-template-03 {
    display: grid;
    grid-template-columns: 38% 62%;
    align-content: start;
    background: #fff;
}
.paper.template-template-03 .paper-header,
.preview-paper.template-template-03 .paper-header {
    display: contents;
}
.paper.template-template-03 .paper-header > div:first-child,
.preview-paper.template-template-03 .paper-header > div:first-child {
    grid-column: 2;
    grid-row: 1;
    padding: 16px;
    border-top: 12px solid #f58220;
}
.paper.template-template-03 .paper-photo,
.preview-paper.template-template-03 .paper-photo {
    grid-column: 1;
    grid-row: 1;
    background: #f1ead2;
    min-height: 110px;
    border-top: 12px solid #f58220;
}
.paper.template-template-03 .paper-contact,
.preview-paper.template-template-03 .paper-contact,
.paper.template-template-03 #skillsSection,
.preview-paper.template-template-03 #skillsSection,
.paper.template-template-03 #educationSection,
.preview-paper.template-template-03 #educationSection {
    grid-column: 1;
    background: #f1ead2;
    padding: 8px;
}
.paper.template-template-03 .paper-section,
.preview-paper.template-template-03 .paper-section {
    grid-column: 2;
    padding: 8px 12px;
}

/* 04 - Minimal */
.paper.template-template-04,
.preview-paper.template-template-04 {
    font-family: Arial, sans-serif;
    border-top: 0;
}
.paper.template-template-04 .paper-header,
.preview-paper.template-template-04 .paper-header {
    border: 0;
    box-shadow: none;
}
.paper.template-template-04 .paper-name,
.preview-paper.template-template-04 .paper-name {
    font-weight: 400;
    letter-spacing: -1px;
}

/* 05 - Teal Accent */
.paper.template-template-05,
.preview-paper.template-template-05 {
    border-top: 6px solid #0f766e;
}
.paper.template-template-05 .paper-section-title,
.preview-paper.template-template-05 .paper-section-title {
    color: #0f766e;
    border-bottom: 1px solid #ddd;
}

/* 06 - Creative */
.paper.template-template-06,
.preview-paper.template-template-06 {
    border-left: 7px solid #7c3aed;
}
.paper.template-template-06 .paper-name,
.preview-paper.template-template-06 .paper-name {
    color: #7c3aed;
}
.paper.template-template-06 .paper-section-title,
.preview-paper.template-template-06 .paper-section-title {
    border-left: 4px solid #7c3aed;
    padding-left: 8px;
}

/* 07 - Developer */
.paper.template-template-07,
.preview-paper.template-template-07 {
    font-family: "Courier New", monospace;
    background: #f7f7f7;
}
.paper.template-template-07 .paper-header,
.preview-paper.template-template-07 .paper-header {
    border-bottom: 2px dashed #16a34a;
}

/* 08 - Left Rail */
.paper.template-template-08,
.preview-paper.template-template-08 {
    border-left: 14px solid #1e293b;
    padding-left: 60px !important;
}

/* 09 - Editorial */
.paper.template-template-09,
.preview-paper.template-template-09 {
    font-family: Georgia, serif;
}
.paper.template-template-09 .paper-header,
.preview-paper.template-template-09 .paper-header {
    justify-content: center;
    text-align: center;
    border-bottom: 3px double var(--accent);
}

/* 10 - Double line */
.paper.template-template-10,
.preview-paper.template-template-10 {
    border-top: 4px double #b45309;
}
.paper.template-template-10 .paper-header,
.preview-paper.template-template-10 .paper-header {
    border-bottom: 3px double #b45309;
}

/* 11 - Compact */
.paper.template-template-11,
.preview-paper.template-template-11 {
    font-family: Arial, sans-serif;
}
.paper.template-template-11 .paper-section,
.preview-paper.template-template-11 .paper-section {
    margin-top: 12px;
}

/* 12 - Sand Signature */
.paper.template-template-12,
.preview-paper.template-template-12 {
    border-top: 10px solid #8b735f;
}
.paper.template-template-12 .paper-name,
.preview-paper.template-template-12 .paper-name {
    color: #8b735f;
}


/* FIX: Template 01 - Navy Wave layout */
#paper.template-template-01,
#previewPaper.template-template-01 {
    display: grid !important;
    grid-template-columns: 38% 62% !important;
    align-content: start;
    gap: 0 16px;
    padding: 32px !important;
    box-sizing: border-box;
}
#paper.template-template-01 .paper-header,
#previewPaper.template-template-01 .paper-header {
    display: contents !important;
}
#paper.template-template-01 .paper-header > div:first-child,
#previewPaper.template-template-01 .paper-header > div:first-child {
    grid-column: 2;
    grid-row: 1;
}
#paper.template-template-01 .paper-photo,
#previewPaper.template-template-01 .paper-photo {
    grid-column: 1;
    grid-row: 1 / span 2;
}
#paper.template-template-01 .paper-contact,
#previewPaper.template-template-01 .paper-contact,
#paper.template-template-01 #skillsSection,
#previewPaper.template-template-01 #skillsSection {
    grid-column: 1;
}
#paper.template-template-01 .paper-section:not(#skillsSection),
#previewPaper.template-template-01 .paper-section:not(#skillsSection) {
    grid-column: 2;
}</style>

</head>


<body>


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
                value="<%= selectedTitle %>"
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
            value="<%= fullName %>"
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
                value="<%= email %>"
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
            placeholder="Mumbai, India"
            oninput="updatePreview()"
        >

    </div>

    <div class="field photo-upload-field">

        <label>
            PROFILE PHOTO
        </label>

        <div class="photo-upload-row">

            <div class="photo-upload-preview" id="photoUploadPreview">
                <span id="photoUploadInitial">+</span>
                <img id="photoUploadImage" alt="Profile photo">
            </div>

            <div class="photo-upload-actions">

                <input
                    id="profilePhoto"
                    type="file"
                    accept="image/png,image/jpeg,image/webp"
                    hidden
                >

                <button
                    type="button"
                    class="photo-upload-button"
                    onclick="document.getElementById('profilePhoto').click()"
                >
                    Upload photo
                </button>

                <button
                    type="button"
                    class="photo-remove-button"
                    onclick="removeProfilePhoto()"
                >
                    Remove
                </button>

                <span class="photo-upload-help">
                    JPG, PNG or WEBP · max 5 MB
                </span>

            </div>

        </div>

    </div>


    <div class="two-fields">

        <div class="field">

            <label>
                LINKEDIN
            </label>

            <input
                id="linkedin"
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
                placeholder="github.com/..."
                oninput="updatePreview()"
            >

        </div>

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
        ></textarea>

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
        ></textarea>

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
        ></textarea>

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
        >

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
        ></textarea>

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
        >

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
        <button type="button" class="template-option selected" data-template="template-01" onclick="selectTemplate(this,'template-01')" aria-label="Select Clean Professional">
            <div class="mini-paper mini-01"><b></b><i></i><hr><em></em><i></i><i></i></div><span>01 · CLEAN</span>
        </button>
        <button type="button" class="template-option" data-template="template-02" onclick="selectTemplate(this,'template-02')" aria-label="Select Bold Header">
            <div class="mini-paper mini-02"><b></b><i></i><hr><em></em><i></i><i></i></div><span>02 · BOLD</span>
        </button>
        <button type="button" class="template-option" data-template="template-03" onclick="selectTemplate(this,'template-03')" aria-label="Select Editorial">
            <div class="mini-paper mini-03"><b></b><i></i><hr><em></em><i></i><i></i></div><span>03 · EDITORIAL</span>
        </button>
        <button type="button" class="template-option" data-template="template-04" onclick="selectTemplate(this,'template-04')" aria-label="Select Minimal">
            <div class="mini-paper mini-04"><b></b><i></i><hr><em></em><i></i><i></i></div><span>04 · MINIMAL</span>
        </button>
        <button type="button" class="template-option" data-template="template-05" onclick="selectTemplate(this,'template-05')" aria-label="Select Accent Line">
            <div class="mini-paper mini-05"><b></b><i></i><hr><em></em><i></i><i></i></div><span>05 · ACCENT</span>
        </button>
        <button type="button" class="template-option" data-template="template-06" onclick="selectTemplate(this,'template-06')" aria-label="Select Creative">
            <div class="mini-paper mini-06"><b></b><i></i><hr><em></em><i></i><i></i></div><span>06 · CREATIVE</span>
        </button>
        <button type="button" class="template-option" data-template="template-07" onclick="selectTemplate(this,'template-07')" aria-label="Select Developer">
            <div class="mini-paper mini-07"><b></b><i></i><hr><em></em><i></i><i></i></div><span>07 · DEVELOPER</span>
        </button>
        <button type="button" class="template-option" data-template="template-08" onclick="selectTemplate(this,'template-08')" aria-label="Select Left Rail">
            <div class="mini-paper mini-08"><b></b><i></i><hr><em></em><i></i><i></i></div><span>08 · LEFT RAIL</span>
        </button>
        <button type="button" class="template-option" data-template="template-09" onclick="selectTemplate(this,'template-09')" aria-label="Select Traditional">
            <div class="mini-paper mini-09"><b></b><i></i><hr><em></em><i></i><i></i></div><span>09 · TRADITIONAL</span>
        </button>
        <button type="button" class="template-option" data-template="template-10" onclick="selectTemplate(this,'template-10')" aria-label="Select Double Rule">
            <div class="mini-paper mini-10"><b></b><i></i><hr><em></em><i></i><i></i></div><span>10 · DOUBLE RULE</span>
        </button>
        <button type="button" class="template-option" data-template="template-11" onclick="selectTemplate(this,'template-11')" aria-label="Select Compact">
            <div class="mini-paper mini-11"><b></b><i></i><hr><em></em><i></i><i></i></div><span>11 · COMPACT</span>
        </button>
        <button type="button" class="template-option" data-template="template-12" onclick="selectTemplate(this,'template-12')" aria-label="Select Signature">
            <div class="mini-paper mini-12"><b></b><i></i><hr><em></em><i></i><i></i></div><span>12 · SIGNATURE</span>
        </button>
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
        <img id="previewPhoto" alt="Profile photo">
        <span id="previewPhotoPlaceholder">PHOTO</span>
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
        <img id="rightPreviewPhoto" alt="Profile photo">
        <span id="rightPreviewPhotoPlaceholder">PHOTO</span>
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
   SERVER DATA
========================================================= */

const smartResumeContextPath = "<%= js(contextPath) %>";

const savedResumeData = {
    resumeId: <%= savedResume == null ? "null" : String.valueOf(savedResume.getResumeId()) %>,
    resumeTitle: "<%= js(selectedTitle) %>",
    fullName: "<%= js(savedResume == null ? fullName : savedResume.getFullName()) %>",
    email: "<%= js(savedResume == null ? email : savedResume.getEmail()) %>",
    phone: "<%= js(savedResume == null ? "" : savedResume.getPhone()) %>",
    location: "<%= js(savedResume == null ? "" : savedResume.getLocation()) %>",
    linkedin: "<%= js(savedResume == null ? "" : savedResume.getLinkedin()) %>",
    github: "<%= js(savedResume == null ? "" : savedResume.getGithub()) %>",
    summary: "<%= js(savedResume == null ? "" : savedResume.getSummary()) %>",
    education: "<%= js(savedResume == null ? "" : savedResume.getEducation()) %>",
    skills: "<%= js(savedResume == null ? "" : savedResume.getSkills()) %>",
    projects: "<%= js(savedResume == null ? "" : savedResume.getProjects()) %>",
    experience: "<%= js(savedResume == null ? "" : savedResume.getExperience()) %>",
    certifications: "<%= js(savedResume == null ? "" : savedResume.getCertifications()) %>",
    languages: "<%= js(savedResume == null ? "" : savedResume.getLanguages()) %>",
    achievements: "<%= js(savedResume == null ? "" : savedResume.getAchievements()) %>",
    interests: "<%= js(savedResume == null ? "" : savedResume.getInterests()) %>",
    profilePhoto: "<%= js(savedPhoto) %>",
    template: "<%= js(selectedTemplate) %>",
    themeColor: "<%= js(selectedThemeColor) %>"
};

let currentProfilePhoto = savedResumeData.profilePhoto || "";


/* =========================================================
   STATE
========================================================= */

let currentZoom = 0.70;

let currentPreviewZoom = 0.70;

let currentTemplate = "<%= js(selectedTemplate) %>";

let currentColor = "#111111";

let currentFont = "Arial";

let currentFontSize = 35;

let currentSpacing = 58;


/* =========================================================
   INITIALIZE
========================================================= */

document.addEventListener(
    "DOMContentLoaded",
    function () {

        applyTemplate(currentTemplate);

        applyColor(savedResumeData.themeColor || "#111111");

        loadSavedResume();

        updatePreview();

        updateProfilePhotoPreview();

        const photoInput =
            document.getElementById("profilePhoto");

        if (photoInput) {
            photoInput.addEventListener(
                "change",
                handleProfilePhotoUpload
            );
        }

        applyZoom();

        applyPreviewZoom();

    }
);


/* =========================================================
   LOAD SAVED RESUME
========================================================= */

function setFieldValue(id, value) {
    const element = document.getElementById(id);

    if (element) {
        element.value = value || "";
    }
}

function parseSavedList(value) {
    if (!value || !String(value).trim()) {
        return [];
    }

    try {
        const parsed = JSON.parse(value);
        return Array.isArray(parsed) ? parsed : [];
    } catch (error) {
        return [];
    }
}

function clearContainer(containerId) {
    const container =
        document.getElementById(containerId);

    if (!container) return;

    container.innerHTML = "";
}

function loadExperienceData(items) {

    clearContainer("experienceContainer");

    if (!items.length) {
        addExperience();
        return;
    }

    items.forEach(function (item) {

        addExperience();

        const cards =
            document.querySelectorAll(
                "#experienceContainer .entry-card"
            );

        const card =
            cards[cards.length - 1];

        card.querySelector(".exp-role").value =
            item.role || "";

        card.querySelector(".exp-company").value =
            item.company || "";

        card.querySelector(".exp-start").value =
            item.start || "";

        card.querySelector(".exp-end").value =
            item.end || "";

        card.querySelector(".exp-description").value =
            item.description || "";
    });
}

function loadEducationData(items) {

    clearContainer("educationContainer");

    if (!items.length) {
        addEducation();
        return;
    }

    items.forEach(function (item) {

        addEducation();

        const cards =
            document.querySelectorAll(
                "#educationContainer .entry-card"
            );

        const card =
            cards[cards.length - 1];

        card.querySelector(".edu-degree").value =
            item.degree || "";

        card.querySelector(".edu-school").value =
            item.school || "";

        card.querySelector(".edu-start").value =
            item.start || "";

        card.querySelector(".edu-end").value =
            item.end || "";
    });
}

function loadProjectData(items) {

    clearContainer("projectsContainer");

    if (!items.length) {
        addProject();
        return;
    }

    items.forEach(function (item) {

        addProject();

        const cards =
            document.querySelectorAll(
                "#projectsContainer .entry-card"
            );

        const card =
            cards[cards.length - 1];

        card.querySelector(".project-name").value =
            item.name || "";

        card.querySelector(".project-tech").value =
            item.tech || "";

        card.querySelector(".project-description").value =
            item.description || "";
    });
}

function loadSavedResume() {

    const data =
        savedResumeData;

    setFieldValue(
        "resumeTitle",
        data.resumeTitle
    );

    setFieldValue(
        "fullName",
        data.fullName
    );

    setFieldValue(
        "email",
        data.email
    );

    setFieldValue(
        "phone",
        data.phone
    );

    setFieldValue(
        "location",
        data.location
    );

    setFieldValue(
        "linkedin",
        data.linkedin
    );

    setFieldValue(
        "github",
        data.github
    );

    setFieldValue(
        "summary",
        data.summary
    );

    setFieldValue(
        "skills",
        data.skills
    );

    setFieldValue(
        "certifications",
        data.certifications
    );

    setFieldValue(
        "languages",
        data.languages
    );

    setFieldValue(
        "achievements",
        data.achievements
    );

    setFieldValue(
        "interests",
        data.interests
    );

    loadExperienceData(
        parseSavedList(
            data.experience
        )
    );

    loadEducationData(
        parseSavedList(
            data.education
        )
    );

    loadProjectData(
        parseSavedList(
            data.projects
        )
    );

    currentProfilePhoto =
        data.profilePhoto || "";
}

function updateProfilePhotoPreview() {

    const uploadImage =
        document.getElementById(
            "photoUploadImage"
        );

    const uploadInitial =
        document.getElementById(
            "photoUploadInitial"
        );

    const previewPhoto =
        document.getElementById(
            "previewPhoto"
        );

    const previewPlaceholder =
        document.getElementById(
            "previewPhotoPlaceholder"
        );

    const rightPreviewPhoto =
        document.getElementById(
            "rightPreviewPhoto"
        );

    const rightPreviewPlaceholder =
        document.getElementById(
            "rightPreviewPhotoPlaceholder"
        );

    const photo =
        currentProfilePhoto || "";

    if (photo) {

        if (uploadImage) {
            uploadImage.src = photo;
            uploadImage.style.display =
                "block";
        }

        if (uploadInitial) {
            uploadInitial.style.display =
                "none";
        }

        if (previewPhoto) {
            previewPhoto.src = photo;
            previewPhoto.style.display =
                "block";
        }

        if (previewPlaceholder) {
            previewPlaceholder.style.display =
                "none";
        }

        if (rightPreviewPhoto) {
            rightPreviewPhoto.src = photo;
            rightPreviewPhoto.style.display =
                "block";
        }

        if (rightPreviewPlaceholder) {
            rightPreviewPlaceholder.style.display =
                "none";
        }

    } else {

        if (uploadImage) {
            uploadImage.removeAttribute("src");
            uploadImage.style.display =
                "none";
        }

        if (uploadInitial) {
            uploadInitial.style.display =
                "block";
        }

        if (previewPhoto) {
            previewPhoto.removeAttribute("src");
            previewPhoto.style.display =
                "none";
        }

        if (previewPlaceholder) {
            previewPlaceholder.style.display =
                "block";
        }

        if (rightPreviewPhoto) {
            rightPreviewPhoto.removeAttribute("src");
            rightPreviewPhoto.style.display =
                "none";
        }

        if (rightPreviewPlaceholder) {
            rightPreviewPlaceholder.style.display =
                "block";
        }
    }
}

function removeProfilePhoto() {

    currentProfilePhoto = "";

    const input =
        document.getElementById(
            "profilePhoto"
        );

    if (input) {
        input.value = "";
    }

    updateProfilePhotoPreview();
}

function handleProfilePhotoUpload(event) {

    const file =
        event.target.files &&
        event.target.files[0];

    if (!file) return;

    if (!file.type.startsWith("image/")) {

        alert(
            "Please select an image file."
        );

        event.target.value = "";

        return;
    }

    if (file.size > 5 * 1024 * 1024) {

        alert(
            "Profile photo must be smaller than 5 MB."
        );

        event.target.value = "";

        return;
    }

    const reader =
        new FileReader();

    reader.onload =
        function () {

            currentProfilePhoto =
                reader.result;

            updateProfilePhotoPreview();

            updatePreview();
        };

    reader.readAsDataURL(file);
}


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

    if (!/^template-(0[1-9]|1[0-2])$/.test(template || "")) {
        template = "template-01";
    }
    currentTemplate = template;

    document.querySelectorAll(".template-option").forEach(function (option) {
        option.classList.toggle("selected", option.dataset.template === template);
    });

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
    "template-corporate",
    "template-template-01",
    "template-template-02",
    "template-template-03",
    "template-template-04",
    "template-template-05",
    "template-template-06",
    "template-template-07",
    "template-template-08",
    "template-template-09",
    "template-template-10",
    "template-template-11",
    "template-template-12"
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


            /* RESET template-specific inline styling before applying the selected design */
            header.style.background = "";
            header.style.padding = "";
            header.style.borderBottom = "";
            name.style.color = "";
            name.style.fontFamily = "";
            name.style.fontWeight = "";
            name.style.letterSpacing = "";
            role.style.color = "";
            role.style.fontFamily = "";
            role.style.fontStyle = "";
            titles.forEach(function (title) {
                title.style.color = "";
                title.style.borderLeft = "";
                title.style.paddingLeft = "";
                title.style.borderBottom = "";
                title.style.paddingBottom = "";
                title.style.fontSize = "";
                title.style.letterSpacing = "";
                title.style.fontFamily = "";
            });
            skills.forEach(function (skill) {
                skill.style.background = "";
                skill.style.color = "";
                skill.style.border = "";
                skill.style.borderRadius = "";
                skill.style.fontFamily = "";
            });

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
                "legacy-modern"
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
                "legacy-sidebar"
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
                "legacy-classic"
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
                "legacy-minimal"
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
                "legacy-executive"
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
                "legacy-creative"
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
                "legacy-developer"
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
                "legacy-corporate"
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

function collectExperience() {

    return JSON.stringify(
        Array.from(
            document.querySelectorAll(
                "#experienceContainer .entry-card"
            )
        )
        .map(function (card) {

            return {
                role:
                    card.querySelector(
                        ".exp-role"
                    )?.value.trim() || "",

                company:
                    card.querySelector(
                        ".exp-company"
                    )?.value.trim() || "",

                start:
                    card.querySelector(
                        ".exp-start"
                    )?.value.trim() || "",

                end:
                    card.querySelector(
                        ".exp-end"
                    )?.value.trim() || "",

                description:
                    card.querySelector(
                        ".exp-description"
                    )?.value.trim() || ""
            };
        })
        .filter(function (item) {

            return item.role ||
                   item.company ||
                   item.description;
        })
    );
}

function collectEducation() {

    return JSON.stringify(
        Array.from(
            document.querySelectorAll(
                "#educationContainer .entry-card"
            )
        )
        .map(function (card) {

            return {
                degree:
                    card.querySelector(
                        ".edu-degree"
                    )?.value.trim() || "",

                school:
                    card.querySelector(
                        ".edu-school"
                    )?.value.trim() || "",

                start:
                    card.querySelector(
                        ".edu-start"
                    )?.value.trim() || "",

                end:
                    card.querySelector(
                        ".edu-end"
                    )?.value.trim() || ""
            };
        })
        .filter(function (item) {

            return item.degree ||
                   item.school;
        })
    );
}

function collectProjects() {

    return JSON.stringify(
        Array.from(
            document.querySelectorAll(
                "#projectsContainer .entry-card"
            )
        )
        .map(function (card) {

            return {
                name:
                    card.querySelector(
                        ".project-name"
                    )?.value.trim() || "",

                tech:
                    card.querySelector(
                        ".project-tech"
                    )?.value.trim() || "",

                description:
                    card.querySelector(
                        ".project-description"
                    )?.value.trim() || ""
            };
        })
        .filter(function (item) {

            return item.name ||
                   item.description;
        })
    );
}

async function saveResume() {

    const status =
        document.getElementById(
            "saveStatus"
        );

    if (status) {
        status.textContent =
            "Saving...";
    }

    const formData =
        new FormData();

    function appendField(
        name,
        id
    ) {

        const element =
            document.getElementById(id);

        formData.append(
            name,
            element
                ? element.value
                : ""
        );
    }

    appendField(
        "resumeTitle",
        "resumeTitle"
    );

    appendField(
        "fullName",
        "fullName"
    );

    appendField(
        "email",
        "email"
    );

    appendField(
        "phone",
        "phone"
    );

    appendField(
        "location",
        "location"
    );

    appendField(
        "linkedin",
        "linkedin"
    );

    appendField(
        "github",
        "github"
    );

    appendField(
        "summary",
        "summary"
    );

    appendField(
        "skills",
        "skills"
    );

    appendField(
        "certifications",
        "certifications"
    );

    appendField(
        "languages",
        "languages"
    );

    appendField(
        "achievements",
        "achievements"
    );

    appendField(
        "interests",
        "interests"
    );

    formData.append(
        "education",
        collectEducation()
    );

    formData.append(
        "experience",
        collectExperience()
    );

    formData.append(
        "projects",
        collectProjects()
    );

    formData.append(
        "template",
        currentTemplate || "template-01"
    );

    formData.append(
        "themeColor",
        currentColor || "#111111"
    );

    if (savedResumeData.resumeId) {

        formData.append(
            "resumeId",
            savedResumeData.resumeId
        );
    }

    const photoInput =
        document.getElementById(
            "profilePhoto"
        );

    if (
        photoInput &&
        photoInput.files &&
        photoInput.files.length > 0
    ) {

        formData.append(
            "profilePhoto",
            photoInput.files[0]
        );

    } else if (
        currentProfilePhoto
    ) {

        formData.append(
            "existingProfilePhoto",
            currentProfilePhoto
        );
    }

    
try {
    const response = await fetch(
        smartResumeContextPath + "/resume-builder",
        {
            method: "POST",
            body: formData
        }
    );

    if (!response.ok) {
        const detail = await response.text();

        console.error(
            "SmartResume save failed:",
            response.status,
            detail
        );

        if (status) {
            status.textContent =
                "Save failed (" + response.status + ")";
        }

        const readableDetail = detail
            .replace(/<[^>]*>/g, " ")
            .replace(/\s+/g, " ")
            .trim()
            .slice(0, 350);

        alert(
            "Resume save failed: HTTP " +
            response.status +
            "\n\n" +
            readableDetail
        );

        return;
    }

    window.location.href = response.url;

} catch (error) {
    console.error("SmartResume save error:", error);

    if (status) {
        status.textContent = "Save failed";
    }

    alert(
        "Could not connect to the server. " +
        "Check whether Tomcat is running."
    );
}

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

                    status.textContent =
                        "Unsaved changes";

                },
                1000
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
