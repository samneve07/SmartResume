<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String contextPath = request.getContextPath();

    String fullName = (String) session.getAttribute("fullName");
    String email = (String) session.getAttribute("email");

    if (fullName == null || fullName.trim().isEmpty()) {
        fullName = "there";
    }

    String firstName = fullName.split(" ")[0];

    String initials = firstName.substring(0, 1).toUpperCase();

    if (fullName.contains(" ")) {
        String[] parts = fullName.trim().split("\\s+");
        if (parts.length > 1) {
            initials =
                (parts[0].substring(0, 1)
                + parts[parts.length - 1].substring(0, 1))
                .toUpperCase();
        }
    }

    // Accurate account-basics indicator using the session data this page actually has.
    int accountBasicsCompletion = 0;
    if (fullName != null && !fullName.trim().isEmpty() && !"there".equals(fullName)) {
        accountBasicsCompletion += 50;
    }
    if (email != null && !email.trim().isEmpty()) {
        accountBasicsCompletion += 50;
    }
    String accountBasicsStatus = accountBasicsCompletion == 100 ? "COMPLETE" :
                                 accountBasicsCompletion == 50 ? "IN PROGRESS" : "INCOMPLETE";
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0"
    >

    <title>Dashboard — SmartResume</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        :root {
            --black: #101010;
            --black-soft: #171717;
            --lime: #c8ff32;
            --lime-dark: #a8db18;
            --white: #ffffff;
            --bg: #f5f5f2;
            --muted: #737373;
            --line: #e6e6e2;
            --card: #ffffff;
            --blue: #5b6cff;
            --purple: #8b5cf6;
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
            color: var(--black);

            min-height: 100vh;
        }

        button,
        a,
        input {
            font: inherit;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        /* =========================
           APP SHELL
        ========================= */

        .app {
            min-height: 100vh;
            display: flex;
        }

        /* =========================
           SIDEBAR
        ========================= */

        .sidebar {
            width: 250px;
            background: var(--black);
            color: white;

            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;

            display: flex;
            flex-direction: column;

            z-index: 100;
        }

        .brand {
            height: 82px;
            padding: 0 24px;

            display: flex;
            align-items: center;
            gap: 12px;

            border-bottom: 1px solid rgba(255,255,255,.08);
        }

        .brand-mark {
            width: 38px;
            height: 38px;

            background: var(--lime);
            color: #111;

            border-radius: 11px;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 20px;
            font-weight: 900;

            box-shadow: 0 0 0 3px rgba(200,255,50,.08);
        }

        .brand-name {
            font-size: 19px;
            font-weight: 750;
            letter-spacing: -0.5px;
        }

        .brand-sub {
            color: #777;
            font-size: 10px;
            letter-spacing: 1.5px;
            margin-top: 2px;
            text-transform: uppercase;
        }

        .sidebar-content {
            padding: 25px 14px;
            flex: 1;
        }

        .nav-label {
            color: #666;
            font-size: 10px;
            font-weight: 700;
            letter-spacing: 1.5px;

            padding: 0 12px;
            margin: 5px 0 10px;
        }

        .nav-item {
            height: 46px;

            display: flex;
            align-items: center;
            gap: 12px;

            padding: 0 13px;
            margin-bottom: 5px;

            border-radius: 10px;

            color: #999;

            font-size: 14px;
            font-weight: 600;

            transition: .2s ease;
        }

        .nav-item:hover {
            background: rgba(255,255,255,.06);
            color: white;
        }

        .nav-item.active {
            background: var(--lime);
            color: #111;
        }

        .nav-icon {
            width: 21px;
            text-align: center;
            font-size: 17px;
        }

        .sidebar-bottom {
            padding: 14px;
            border-top: 1px solid rgba(255,255,255,.08);
        }

        .profile-mini {
            display: flex;
            align-items: center;
            gap: 11px;

            padding: 10px;
            border-radius: 12px;

            transition: .2s;
        }

        .profile-mini:hover {
            background: rgba(255,255,255,.06);
        }

        .avatar {
            width: 38px;
            height: 38px;

            border-radius: 50%;

            background:
                linear-gradient(
                    135deg,
                    var(--lime),
                    #eaffae
                );

            color: #111;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 12px;
            font-weight: 900;
        }

        .profile-name {
            font-size: 13px;
            font-weight: 700;
        }

        .profile-email {
            color: #777;
            font-size: 10px;

            max-width: 145px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        /* =========================
           MAIN
        ========================= */

        .main {
            margin-left: 250px;
            width: calc(100% - 250px);

            min-height: 100vh;
        }

        .topbar {
            height: 82px;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 42px;

            background: rgba(245,245,242,.9);

            border-bottom: 1px solid var(--line);

            position: sticky;
            top: 0;
            z-index: 50;

            backdrop-filter: blur(18px);
        }

        .page-title small {
            display: block;

            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 1.5px;

            color: #999;

            margin-bottom: 4px;
        }

        .page-title h1 {
            font-size: 20px;
            letter-spacing: -0.7px;
        }

        .top-actions {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .icon-button {
            width: 40px;
            height: 40px;

            border: 1px solid var(--line);
            background: white;

            border-radius: 10px;

            cursor: pointer;

            display: flex;
            align-items: center;
            justify-content: center;

            transition: .2s;
        }

        .icon-button:hover {
            border-color: #ccc;
            transform: translateY(-1px);
        }

        .top-avatar {
            width: 40px;
            height: 40px;

            border-radius: 11px;

            background: #111;
            color: var(--lime);

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 12px;
            font-weight: 800;
        }

        /* =========================
           CONTENT
        ========================= */

        .content {
            padding: 42px;
            max-width: 1550px;
        }

        /* =========================
           HERO
        ========================= */

        .welcome {
            background: var(--black);
            color: white;

            border-radius: 22px;

            padding: 34px 36px;

            min-height: 190px;

            display: flex;
            justify-content: space-between;
            align-items: center;

            position: relative;
            overflow: hidden;

            margin-bottom: 25px;
        }

        .welcome::after {
            content: "";

            position: absolute;

            width: 330px;
            height: 330px;

            right: 90px;
            top: -210px;

            background: var(--lime);

            border-radius: 50%;

            opacity: .12;
            filter: blur(5px);
        }

        .welcome::before {
            content: "";

            position: absolute;

            width: 180px;
            height: 180px;

            right: -30px;
            bottom: -90px;

            border: 1px solid rgba(200,255,50,.3);

            border-radius: 50%;
        }

        .welcome-text {
            position: relative;
            z-index: 2;
        }

        .welcome-eyebrow {
            color: var(--lime);

            font-size: 10px;
            font-weight: 800;

            letter-spacing: 1.8px;
            text-transform: uppercase;

            margin-bottom: 12px;
        }

        .welcome h2 {
            font-size: clamp(28px, 3vw, 42px);

            line-height: 1;
            letter-spacing: -1.8px;

            margin-bottom: 13px;
        }

        .welcome p {
            color: #aaa;

            font-size: 14px;
            line-height: 1.6;

            max-width: 530px;
        }

        .create-btn {
            position: relative;
            z-index: 3;

            background: var(--lime);
            color: #111;

            border: 0;

            padding: 15px 21px;

            border-radius: 11px;

            font-size: 13px;
            font-weight: 800;

            cursor: pointer;

            display: inline-flex;
            align-items: center;
            gap: 10px;

            transition: .2s;

            white-space: nowrap;
        }

        .create-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(200,255,50,.16);
        }

        /* =========================
           STATS
        ========================= */

        .stats {
            display: grid;
            grid-template-columns:
                repeat(4, 1fr);

            gap: 15px;

            margin-bottom: 28px;
        }

        .stat-card {
            background: white;

            border: 1px solid var(--line);

            border-radius: 17px;

            padding: 22px;

            position: relative;

            overflow: hidden;
        }

        .stat-top {
            display: flex;
            justify-content: space-between;
            align-items: center;

            margin-bottom: 22px;
        }

        .stat-label {
            color: #888;

            font-size: 11px;
            font-weight: 700;

            text-transform: uppercase;
            letter-spacing: .8px;
        }

        .stat-icon {
            width: 33px;
            height: 33px;

            background: #f4f4f1;

            border-radius: 9px;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 15px;
        }

        .stat-number {
            font-size: 31px;
            font-weight: 800;

            letter-spacing: -1.5px;

            margin-bottom: 5px;
        }

        .stat-description {
            color: #999;
            font-size: 11px;
        }

        .stat-accent {
            position: absolute;

            bottom: 0;
            left: 0;

            height: 3px;
            width: 42%;

            background: var(--lime);
        }

        /* =========================
           GRID
        ========================= */

        .dashboard-grid {
            display: grid;

            grid-template-columns:
                minmax(0, 1.6fr)
                minmax(300px, .8fr);

            gap: 20px;
        }

        .panel {
            background: white;

            border: 1px solid var(--line);

            border-radius: 18px;

            overflow: hidden;
        }

        .panel-header {
            min-height: 68px;

            padding: 0 22px;

            display: flex;
            align-items: center;
            justify-content: space-between;

            border-bottom: 1px solid var(--line);
        }

        .panel-title {
            font-size: 15px;
            font-weight: 800;

            letter-spacing: -.3px;
        }

        .panel-subtitle {
            color: #999;
            font-size: 11px;

            margin-top: 3px;
        }

        .view-all {
            color: #555;

            font-size: 11px;
            font-weight: 700;

            border-bottom: 1px solid #aaa;

            padding-bottom: 2px;
        }

        .view-all:hover {
            color: #111;
        }

        /* =========================
           RESUME ROW
        ========================= */

        .resume-list {
            padding: 7px 10px;
        }

        .resume-row {
            min-height: 86px;

            padding: 13px 12px;

            display: flex;
            align-items: center;

            gap: 14px;

            border-bottom: 1px solid #f0f0ed;

            transition: .18s;
        }

        .resume-row:last-child {
            border-bottom: 0;
        }

        .resume-row:hover {
            background: #fafaf7;
            border-radius: 11px;
        }

        .resume-thumb {
            width: 48px;
            height: 62px;

            background:
                linear-gradient(
                    145deg,
                    #f0f0ed,
                    #ffffff
                );

            border: 1px solid #ddd;

            border-radius: 6px;

            padding: 8px;

            flex-shrink: 0;

            position: relative;
        }

        .resume-thumb::before {
            content: "";

            display: block;

            height: 4px;
            width: 25px;

            background: #111;

            margin-bottom: 6px;

            border-radius: 2px;
        }

        .resume-thumb::after {
            content:
                "━━━━━━━━\A"
                "━━━━━━\A"
                "━━━━━━━━\A"
                "━━━━";

            white-space: pre;

            font-size: 4px;
            line-height: 7px;

            color: #bbb;
        }

        .resume-info {
            min-width: 0;
            flex: 1;
        }

        .resume-name {
            font-size: 13px;
            font-weight: 750;

            margin-bottom: 5px;

            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .resume-date {
            color: #999;
            font-size: 10px;
        }

        .resume-status {
            padding: 5px 8px;

            border-radius: 100px;

            background: #f0ffd0;
            color: #4b6900;

            font-size: 9px;
            font-weight: 800;

            text-transform: uppercase;
        }

        .resume-arrow {
            width: 31px;
            height: 31px;

            border-radius: 8px;

            border: 1px solid #e4e4e0;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 13px;

            transition: .2s;
        }

        .resume-row:hover .resume-arrow {
            background: #111;
            color: var(--lime);
            border-color: #111;
        }

        .empty-state {
            padding: 42px 20px;

            text-align: center;
        }

        .empty-icon {
            width: 50px;
            height: 50px;

            background: #f4f4f1;

            border-radius: 14px;

            margin: 0 auto 14px;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 21px;
        }

        .empty-state h3 {
            font-size: 14px;
            margin-bottom: 6px;
        }

        .empty-state p {
            color: #999;
            font-size: 11px;
            margin-bottom: 17px;
        }

        .small-create {
            border: 1px solid #ddd;

            background: white;

            border-radius: 8px;

            padding: 9px 13px;

            font-size: 11px;
            font-weight: 700;

            cursor: pointer;
        }

        .small-create:hover {
            border-color: #111;
        }

        /* =========================
           RIGHT SIDE
        ========================= */

        .side-stack {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .completion {
            padding: 23px;
        }

        .completion-head {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;

            margin-bottom: 18px;
        }

        .completion-number {
            font-size: 28px;
            font-weight: 850;

            letter-spacing: -1px;
        }

        .completion-label {
            color: #888;
            font-size: 10px;
        }

        .progress {
            height: 7px;

            background: #eeeeea;

            border-radius: 100px;

            overflow: hidden;

            margin-bottom: 9px;
        }

        .progress-fill {
            height: 100%;
            width: 0;

            background: var(--lime);

            border-radius: inherit;
        }

        .completion-foot {
            display: flex;
            justify-content: space-between;

            color: #999;

            font-size: 10px;
        }

        /* =========================
           QUICK ACTIONS
        ========================= */

        .actions {
            padding: 10px;
        }

        .quick-action {
            display: flex;
            align-items: center;
            gap: 12px;

            padding: 12px;

            border-radius: 11px;

            transition: .18s;
        }

        .quick-action:hover {
            background: #f6f6f3;
        }

        .quick-icon {
            width: 38px;
            height: 38px;

            border-radius: 10px;

            background: #f0f0ed;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 16px;
        }

        .quick-text {
            flex: 1;
        }

        .quick-title {
            font-size: 12px;
            font-weight: 750;
        }

        .quick-description {
            color: #999;
            font-size: 9px;
            margin-top: 3px;
        }

        .quick-arrow {
            color: #aaa;
            font-size: 14px;
        }

        /* =========================
           ATS CARD
        ========================= */

        .ats-card {
            background: #111;
            color: white;

            padding: 23px;

            border-radius: 18px;

            position: relative;

            overflow: hidden;
        }

        .ats-card::after {
            content: "";

            position: absolute;

            width: 130px;
            height: 130px;

            right: -45px;
            top: -45px;

            border: 20px solid rgba(200,255,50,.13);

            border-radius: 50%;
        }

        .ats-label {
            color: #aaa;

            font-size: 10px;
            font-weight: 700;

            text-transform: uppercase;
            letter-spacing: 1.2px;

            margin-bottom: 16px;
        }

        .ats-main {
            display: flex;
            align-items: center;
            gap: 17px;
        }

        .ats-score {
            width: 68px;
            height: 68px;

            border-radius: 50%;

            border: 5px solid var(--lime);

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 21px;
            font-weight: 850;
        }

        .ats-text h3 {
            font-size: 14px;
            margin-bottom: 5px;
        }

        .ats-text p {
            color: #888;
            font-size: 10px;
            line-height: 1.5;
        }

        .ats-link {
            display: inline-block;

            margin-top: 18px;

            color: var(--lime);

            font-size: 10px;
            font-weight: 750;
        }

        /* =========================
           MOBILE
        ========================= */

        .mobile-menu {
            display: none;
        }

        @media (max-width: 1050px) {

            .stats {
                grid-template-columns: repeat(2, 1fr);
            }

            .dashboard-grid {
                grid-template-columns: 1fr;
            }

        }

        @media (max-width: 760px) {

            .sidebar {
                transform: translateX(-100%);
                transition: .25s ease;
            }

            .sidebar.open {
                transform: translateX(0);
            }

            .main {
                margin-left: 0;
                width: 100%;
            }

            .topbar {
                padding: 0 18px;
            }

            .content {
                padding: 20px 16px;
            }

            .mobile-menu {
                display: flex;

                width: 40px;
                height: 40px;

                align-items: center;
                justify-content: center;

                border: 1px solid var(--line);

                border-radius: 10px;

                background: white;

                cursor: pointer;

                margin-right: 10px;
            }

            .page-title {
                display: flex;
                align-items: center;
            }

            .welcome {
                padding: 25px;
                align-items: flex-start;
                flex-direction: column;
                gap: 25px;
            }

            .stats {
                grid-template-columns: 1fr 1fr;
                gap: 10px;
            }

            .stat-card {
                padding: 17px;
            }

            .stat-number {
                font-size: 25px;
            }

        }

        @media (max-width: 500px) {

            .stats {
                grid-template-columns: 1fr;
            }

            .top-actions .icon-button {
                display: none;
            }

            .resume-status {
                display: none;
            }

        }


        /* =========================
           FEATURED DASHBOARD ACTIONS
        ========================= */
        .featured-actions-panel { min-width: 0; }
        .featured-actions-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 14px;
            padding: 20px;
        }
        .featured-action {
            min-height: 142px;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            justify-content: space-between;
            gap: 18px;
            padding: 22px;
            border: 1px solid var(--line);
            border-radius: 16px;
            background: #fff;
            transition: transform .18s ease, box-shadow .18s ease, border-color .18s ease;
        }
        .featured-action:hover {
            transform: translateY(-3px);
            border-color: #c8c8be;
            box-shadow: 0 10px 26px rgba(0,0,0,.07);
        }
        .featured-action.build-feature {
            color: #fff;
            background: var(--black);
            border-color: var(--black);
        }
        .featured-action.templates-feature { background: #fbfff2; }
        .featured-action.ats-feature { background: #f5f6ff; }
        .featured-action-top { display: flex; align-items: center; justify-content: space-between; width: 100%; gap: 12px; }
        .featured-action-icon {
            width: 44px; height: 44px; flex: 0 0 44px;
            display: flex; align-items: center; justify-content: center;
            border-radius: 13px; background: #f0f0ed; color: #111; font-size: 22px;
        }
        .build-feature .featured-action-icon { background: var(--lime); }
        .ats-feature .featured-action-icon { background: #e4e7ff; }
        .featured-action-arrow { font-size: 22px; font-weight: 700; }
        .featured-action-title { font-size: 18px; font-weight: 850; letter-spacing: -.4px; margin-bottom: 6px; }
        .featured-action-description { color: #858585; font-size: 12px; line-height: 1.55; }
        .build-feature .featured-action-description { color: #d0d0d0; }
        .completion-number { font-variant-numeric: tabular-nums; }
        .progress-fill { width: <%= accountBasicsCompletion %>%; }
        @media (min-width: 1100px) {
            .dashboard-grid { grid-template-columns: minmax(0, 1.6fr) minmax(300px, .8fr); }
            .featured-actions-grid { grid-template-columns: repeat(3, minmax(0, 1fr)); }
            .featured-action { min-height: 210px; }
            .featured-action-title { font-size: 17px; }
        }
        @media (max-width: 500px) {
            .featured-actions-grid { padding: 14px; }
            .featured-action { padding: 18px; min-height: 130px; }
        }

    </style>

</head>

<body>

<div class="app">

    <!-- =========================
         SIDEBAR
    ========================== -->

    <aside class="sidebar" id="sidebar">

        <div class="brand">

            <div class="brand-mark">
                S
            </div>

            <div>
                <div class="brand-name">
                    SmartResume
                </div>

                <div class="brand-sub">
                    Career workspace
                </div>
            </div>

        </div>


        <div class="sidebar-content">

            <div class="nav-label">
                WORKSPACE
            </div>

            <a
                href="<%= contextPath %>/templates"
                class="nav-item active"
            >
                <span class="nav-icon">⌂</span>
                Dashboard
            </a>

            <a
                href="<%= contextPath %>/resume-builder"
                class="nav-item"
            >
                <span class="nav-icon">＋</span>
                Create Resume
            </a>

            <a
                href="<%= contextPath %>/my-resumes"
                class="nav-item"
            >
                <span class="nav-icon">▤</span>
                My Resumes
            </a>


            <div class="nav-label" style="margin-top:28px;">
                TOOLS
            </div>

            <a
                href="<%= contextPath %>/templates"
                class="nav-item"
            >
                <span class="nav-icon">◈</span>
                Templates
            </a>

            <a
                href="<%= contextPath %>/ats"
                class="nav-item"
            >
                <span class="nav-icon">◎</span>
                ATS Checker
            </a>

            <a
                href="<%= contextPath %>/profile"
                class="nav-item"
            >
                <span class="nav-icon">◉</span>
                Profile
            </a>


            <div class="nav-label" style="margin-top:28px;">
                ACCOUNT
            </div>

            <a
                href="<%= contextPath %>/settings"
                class="nav-item"
            >
                <span class="nav-icon">⚙</span>
                Settings
            </a>

            <a
                href="<%= contextPath %>/logout"
                class="nav-item"
            >
                <span class="nav-icon">↪</span>
                Logout
            </a>

        </div>


        <div class="sidebar-bottom">

            <div class="profile-mini">

                <div class="avatar">
                    <%= initials %>
                </div>

                <div>
                    <div class="profile-name">
                        <%= fullName %>
                    </div>

                    <div class="profile-email">
                        <%= email != null ? email : "SmartResume user" %>
                    </div>
                </div>

            </div>

        </div>

    </aside>


    <!-- =========================
         MAIN
    ========================== -->

    <main class="main">

        <!-- TOPBAR -->

        <header class="topbar">

            <div class="page-title">

                <button
                    class="mobile-menu"
                    onclick="toggleSidebar()"
                >
                    ☰
                </button>

                <div>

                    <small>
                        Workspace
                    </small>

                    <h1>
                        Dashboard
                    </h1>

                </div>

            </div>


            <div class="top-actions">

                <button
                    class="icon-button"
                    title="Notifications"
                >
                    ♢
                </button>

                <a
                    href="<%= contextPath %>/profile"
                    class="top-avatar"
                >
                    <%= initials %>
                </a>

            </div>

        </header>


        <!-- CONTENT -->

        <section class="content">


            <!-- =========================
                 WELCOME
            ========================== -->

            <section class="welcome">

                <div class="welcome-text">

                    <div class="welcome-eyebrow">
                        Your career workspace
                    </div>

                    <h2>
                        Hey <%= firstName %>,<br>
                        let's build something great.
                    </h2>

                    <p>
                        Create a resume that looks sharp,
                        reads clearly and gets through the
                        first screening.
                    </p>

                </div>


                <a
                    href="<%= contextPath %>/resume-builder"
                    class="create-btn"
                >
                    Create new resume
                    <span>↗</span>
                </a>

            </section>


            <!-- =========================
                 STATS
            ========================== -->

            <section class="stats">

                <div class="stat-card">

                    <div class="stat-top">

                        <div class="stat-label">
                            Resumes
                        </div>

                        <div class="stat-icon">
                            ▤
                        </div>

                    </div>

                   
<div class="stat-number">
    <%= request.getAttribute("resumeCount") != null ? request.getAttribute("resumeCount") : 0 %>
</div>


<div class="stat-description">
    <%= request.getAttribute("resumeCount") != null && (Integer)request.getAttribute("resumeCount") > 0 ? "Your saved resumes" : "Start your first resume" %>
</div>


                    <div class="stat-accent"></div>

                </div>


                <div class="stat-card">

                    <div class="stat-top">

                        <div class="stat-label">
                            Profile
                        </div>

                        <div class="stat-icon">
                            ◉
                        </div>

                    </div>

                    <div class="stat-number">
                        <%= accountBasicsCompletion %>%
                    </div>

                    <div class="stat-description">
                        Account basics (name + email)
                    </div>

                    <div
                        class="stat-accent"
                        style="width:<%= accountBasicsCompletion %>%;"
                    ></div>

                </div>


                <div class="stat-card">

                    <div class="stat-top">

                        <div class="stat-label">
                            ATS score
                        </div>

                        <div class="stat-icon">
                            ◎
                        </div>

                    </div>

                    <div class="stat-number">
                        —
                    </div>

                    <div class="stat-description">
                        Analyze your resume
                    </div>

                    <div
                        class="stat-accent"
                        style="background:#5b6cff;"
                    ></div>

                </div>


                <div class="stat-card">

                    <div class="stat-top">

                        <div class="stat-label">
                            Templates
                        </div>

                        <div class="stat-icon">
                            ◈
                        </div>

                    </div>

                    <div class="stat-number">
                        12+
                    </div>

                    <div class="stat-description">
                        Professional designs
                    </div>

                    <div
                        class="stat-accent"
                        style="background:#8b5cf6;"
                    ></div>

                </div>

            </section>


            <!-- =========================
                 MAIN GRID
            ========================== -->

            <div class="dashboard-grid">


                <!-- FEATURED PRIMARY ACTIONS -->

                <div class="panel featured-actions-panel">
                    <div class="panel-header">
                        <div>
                            <div class="panel-title">Your resume workspace</div>
                            <div class="panel-subtitle">Choose what you want to do next</div>
                        </div>
                    </div>

                    <div class="featured-actions-grid">
                        <a href="<%= contextPath %>/resume-builder" class="featured-action build-feature">
                            <div class="featured-action-top">
                                <span class="featured-action-icon">✦</span>
                                <span class="featured-action-arrow">→</span>
                            </div>
                            <div>
                                <div class="featured-action-title">Build a Resume</div>
                                <div class="featured-action-description">Create a polished, professional resume step by step.</div>
                            </div>
                        </a>

                        <a href="<%= contextPath %>/templates" class="featured-action templates-feature">
                            <div class="featured-action-top">
                                <span class="featured-action-icon">◈</span>
                                <span class="featured-action-arrow">→</span>
                            </div>
                            <div>
                                <div class="featured-action-title">Explore Templates</div>
                                <div class="featured-action-description">Browse all 12+ professional resume designs and choose your style.</div>
                            </div>
                        </a>

                        <a href="<%= contextPath %>/ats" class="featured-action ats-feature">
                            <div class="featured-action-top">
                                <span class="featured-action-icon">◎</span>
                                <span class="featured-action-arrow">→</span>
                            </div>
                            <div>
                                <div class="featured-action-title">ATS Checker</div>
                                <div class="featured-action-description">Analyze your resume for ATS readiness and job keywords.</div>
                            </div>
                        </a>
                    </div>
                </div>


                <!-- RIGHT -->

                <div class="side-stack">


                    <!-- PROFILE COMPLETION -->

                    <div class="panel">

                        <div class="panel-header">

                            <div>

                                <div class="panel-title">
                                    Profile strength
                                </div>

                                <div class="panel-subtitle">
                                    Complete your profile
                                </div>

                            </div>

                            <span
                                style="
                                    color:#638000;
                                    font-size:10px;
                                    font-weight:800;
                                "
                            >
                                <%= accountBasicsStatus %>
                            </span>

                        </div>


                        <div class="completion">

                            <div class="completion-head">

                                <div>

                                    <div class="completion-number">
                                        <%= accountBasicsCompletion %>%
                                    </div>

                                    <div class="completion-label">
                                        Account basics complete (name + email)
                                    </div>

                                </div>

                                <div
                                    style="
                                        font-size:22px;
                                    "
                                >
                                    ↗
                                </div>

                            </div>


                            <div class="progress">

                                <div class="progress-fill"></div>

                            </div>


                            <div class="completion-foot">
                                <span>Based on saved account details</span>
                                <span><%= accountBasicsCompletion == 100 ? "2 of 2" : accountBasicsCompletion == 50 ? "1 of 2" : "0 of 2" %> fields</span>
                            </div>

                        </div>

                    </div>


                    <!-- ATS -->

                    <div class="ats-card">

                        <div class="ats-label">
                            SmartResume ATS
                        </div>


                        <div class="ats-main">

                            <div class="ats-score">
                                —
                            </div>

                            <div class="ats-text">

                                <h3>
                                    Ready when you are.
                                </h3>

                                <p>
                                    Analyze your resume against
                                    ATS requirements and job keywords.
                                </p>

                            </div>

                        </div>


                        <a
                            href="<%= contextPath %>/ats"
                            class="ats-link"
                        >
                            Analyze a resume →
                        </a>

                    </div>


                </div>

            </div>


        </section>

    </main>

</div>


<script>

    function toggleSidebar() {

        const sidebar =
            document.getElementById("sidebar");

        sidebar.classList.toggle("open");
    }

</script>

</body>

</html>