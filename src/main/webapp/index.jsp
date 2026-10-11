<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>SmartResume — Build. Polish. Get Noticed.</title>

    <meta name="description"
          content="Build a polished, professional resume with SmartResume. Choose your design, customize it, optimize it for ATS and get noticed.">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

    <style>

        /* =========================================================
           RESET
        ========================================================= */

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            font-family: "DM Sans", Arial, sans-serif;
            background: #f8f8f6;
            color: #111111;
            overflow-x: hidden;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        button {
            font-family: inherit;
        }

        /* =========================================================
           VARIABLES
        ========================================================= */

        :root {
            --black: #111111;
            --dark: #101010;
            --white: #ffffff;
            --cream: #f8f8f6;
            --lime: #c9ff3d;
            --lime-soft: #dcff75;
            --muted: #707070;
            --line: #d9d9d4;
            --dark-line: #303030;
        }

        /* =========================================================
           GLOBAL CONTAINER
        ========================================================= */

        .container {
            width: min(1335px, calc(100% - 70px));
            margin: auto;
        }

        /* =========================================================
           NAVBAR
        ========================================================= */

        .nav-wrap {
            position: fixed;
            top: 20px;
            left: 0;
            width: 100%;
            z-index: 1000;
            pointer-events: none;
        }

        .navbar {
            width: min(1335px, calc(100% - 70px));
            height: 72px;
            margin: auto;

            background: rgba(255,255,255,0.94);
            backdrop-filter: blur(18px);
            -webkit-backdrop-filter: blur(18px);

            border: 1px solid #dededb;
            border-radius: 23px;

            display: flex;
            align-items: center;

            padding: 0 20px 0 22px;

            pointer-events: auto;

            box-shadow:
                0 10px 35px rgba(0,0,0,0.045);
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 24px;
            font-weight: 700;
            letter-spacing: -1px;
        }

        .brand-icon {
            width: 42px;
            height: 42px;

            border-radius: 13px;

            background: #111111;
            color: white;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 19px;
            font-weight: 800;

            box-shadow:
                4px 4px 0 var(--lime);
        }

        .nav-links {
            margin-left: auto;
            display: flex;
            align-items: center;
            gap: 38px;
        }

        .nav-links a {
            font-size: 16px;
            font-weight: 600;
            color: #5c5c5c;
            transition: 0.25s ease;
        }

        .nav-links a:hover {
            color: #111111;
        }

        .nav-actions {
            margin-left: 95px;

            display: flex;
            align-items: center;
            gap: 26px;
        }

        .login-link {
            font-weight: 600;
            font-size: 16px;
        }

        .create-btn {
            height: 48px;
            padding: 0 23px;

            border-radius: 15px;

            background: #111111;
            color: white;

            display: flex;
            align-items: center;
            gap: 8px;

            font-size: 15px;
            font-weight: 700;

            transition: 0.25s ease;
        }

        .create-btn span {
            color: var(--lime);
            font-size: 18px;
        }

        .create-btn:hover {
            transform: translateY(-2px);
            background: #202020;
        }

        /* =========================================================
           HERO
        ========================================================= */

        .hero {
            min-height: 820px;
            position: relative;

            overflow: hidden;

            background:
                radial-gradient(
                    circle at 8% 32%,
                    rgba(201,255,61,0.12),
                    transparent 27%
                ),
                radial-gradient(
                    circle at 92% 55%,
                    rgba(188,181,255,0.10),
                    transparent 30%
                ),
                #fafaf8;
        }

        .hero-inner {
            min-height: 820px;

            display: grid;
            grid-template-columns: 48% 52%;
            align-items: center;

            padding-top: 95px;
        }

        .hero-left {
            position: relative;
            z-index: 5;

            padding-top: 45px;
        }

        .hero-pill {
            display: inline-flex;
            align-items: center;
            gap: 9px;

            padding: 9px 14px;

            border: 1px solid #d9ddd0;
            border-radius: 999px;

            background: rgba(255,255,255,0.75);

            font-size: 14px;
            font-weight: 600;

            color: #3d3d3d;

            margin-bottom: 37px;
        }

        .hero-dot {
            width: 8px;
            height: 8px;

            background: var(--lime);

            border-radius: 50%;

            box-shadow: 0 0 0 5px rgba(201,255,61,0.16);
        }

        .hero-title {
            font-family: "Inter", sans-serif;

            font-size: clamp(72px, 7vw, 108px);

            line-height: 0.98;

            letter-spacing: -6px;

            font-weight: 800;

            max-width: 650px;
        }

        .hero-underline {
            height: 11px;

            width: 610px;
            max-width: 90%;

            background: var(--lime);

            margin-top: 7px;
        }

        .hero-description {
            margin-top: 28px;

            max-width: 630px;

            font-size: 19px;
            line-height: 1.65;

            color: #69707a;
        }

        .hero-buttons {
            display: flex;
            align-items: center;
            gap: 13px;

            margin-top: 30px;
        }

        .hero-main-btn {
            background: #111111;
            color: white;

            padding: 17px 24px;

            border-radius: 15px;

            font-weight: 700;

            transition: 0.25s ease;
        }

        .hero-main-btn:hover {
            transform: translateY(-3px);
        }

        .hero-secondary-btn {
            background: white;

            border: 1px solid #d5d5d1;

            padding: 17px 24px;

            border-radius: 15px;

            font-weight: 700;
        }

        .audience {
            margin-top: 32px;

            display: flex;
            align-items: center;
            gap: 13px;
        }

        .avatars {
            display: flex;
        }

        .avatar {
            width: 32px;
            height: 32px;

            border-radius: 50%;

            border: 2px solid white;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 11px;
            font-weight: 800;

            margin-left: -5px;
        }

        .avatar:first-child {
            margin-left: 0;
        }

        .avatar.a {
            background: #d9e9ff;
        }

        .avatar.r {
            background: #ffd7e1;
        }

        .avatar.s {
            background: #dfd5ff;
        }

        .avatar.m {
            background: #d8f3ca;
        }

        .avatar.k {
            background: #ffe3b0;
        }

        .audience-text strong {
            display: block;
            font-size: 14px;
        }

        .audience-text span {
            color: #777;
            font-size: 14px;
        }

        /* =========================================================
           HERO RESUME MOCKUP
        ========================================================= */

        .hero-right {
            position: relative;
            height: 700px;
        }

        .resume-sheet {
            position: absolute;

            width: 555px;
            height: 690px;

            right: 30px;
            top: 100px;

            background: #ffffff;

            border-radius: 4px;

            transform: rotate(2.5deg);

            box-shadow:
                0 35px 80px rgba(0,0,0,0.13);

            padding: 48px 55px;

            overflow: hidden;
        }

        .resume-name {
            font-family: Inter, sans-serif;

            font-size: 28px;
            font-weight: 800;

            letter-spacing: -1.5px;
        }

        .resume-role {
            margin-top: 4px;

            font-size: 11px;
            font-weight: 600;

            color: #777;
        }

        .resume-line {
            height: 2px;

            background: #171717;

            margin: 30px 0 25px;
        }

        .resume-contact {
            display: flex;
            gap: 12px;

            font-size: 8px;
            color: #888;
        }

        .resume-section {
            margin-top: 26px;
        }

        .resume-section-title {
            font-size: 9px;
            font-weight: 800;
            letter-spacing: 1px;
        }

        .fake-line {
            height: 7px;

            background: #e6e6e4;

            border-radius: 5px;

            margin-top: 8px;
        }

        .fake-line.small {
            width: 70%;
        }

        .fake-line.medium {
            width: 85%;
        }

        .fake-line.short {
            width: 48%;
        }

        .photo-circle {
            position: absolute;

            right: 40px;
            top: 42px;

            width: 60px;
            height: 60px;

            border-radius: 50%;

            background: #dedede;

            display: flex;
            align-items: center;
            justify-content: center;

            color: #888;
            font-size: 17px;
        }

        /* ATS FLOAT CARD */

        .ats-float {
            position: absolute;

            z-index: 5;

            left: 5px;
            top: 210px;

            width: 215px;

            padding: 18px;

            border-radius: 18px;

            background: rgba(255,255,255,0.94);

            box-shadow:
                0 20px 45px rgba(0,0,0,0.12);

            transform: rotate(-3deg);
        }

        .ats-top {
            display: flex;
            justify-content: space-between;
            align-items: center;

            font-size: 11px;
            font-weight: 700;
        }

        .ats-badge {
            background: #e8f9bc;

            color: #679400;

            padding: 5px 9px;

            border-radius: 8px;

            font-size: 9px;
        }

        .ats-body {
            display: flex;
            align-items: center;
            gap: 13px;

            margin-top: 15px;
        }

        .score-circle {
            width: 50px;
            height: 50px;

            border-radius: 50%;

            border: 7px solid #111;

            border-right-color: var(--lime);

            border-bottom-color: var(--lime);

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 12px;
            font-weight: 800;
        }

        .ats-body strong {
            font-size: 11px;
        }

        .ats-body p {
            font-size: 8px;
            line-height: 1.4;

            color: #8a8a8a;

            margin-top: 4px;
        }

        /* TEMPLATE FLOAT CARD */

        .template-float {
            position: absolute;

            right: -10px;
            bottom: 80px;

            z-index: 5;

            width: 215px;

            background: white;

            padding: 18px;

            border-radius: 18px;

            box-shadow:
                0 20px 45px rgba(0,0,0,0.12);

            transform: rotate(3deg);
        }

        .template-header {
            display: flex;
            justify-content: space-between;
            align-items: center;

            font-size: 11px;
            font-weight: 700;
        }

        .new-badge {
            background: #e9f9c3;

            color: #6a8e0a;

            padding: 5px 8px;

            border-radius: 8px;

            font-size: 8px;
        }

        .template-mini {
            display: flex;
            gap: 12px;

            margin-top: 15px;
        }

        .template-side {
            width: 30px;
            height: 78px;

            background: #161616;

            border-radius: 2px;
        }

        .template-lines {
            flex: 1;
            padding-top: 5px;
        }

        /* =========================================================
           STATS
        ========================================================= */

        .stats-section {
            background: #111111;
            color: white;

            padding: 0 0 85px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4,1fr);

            border-top: 1px solid #333;
            border-bottom: 1px solid #333;
        }

        .stat {
            min-height: 160px;

            display: flex;
            flex-direction: column;
            justify-content: center;

            padding-left: 80px;

            border-right: 1px solid #333;
        }

        .stat:last-child {
            border-right: none;
        }

        .stat-number {
            font-family: Inter, sans-serif;

            font-size: 48px;

            font-weight: 800;

            letter-spacing: -2px;
        }

        .stat-number span {
            color: var(--lime);
        }

        .stat-label {
            margin-top: 8px;

            font-size: 13px;

            color: #8b8b8b;
        }

        /* =========================================================
           LIME STATEMENT
        ========================================================= */

        .lime-section {
            background: var(--lime);

            min-height: 570px;

            display: flex;
            align-items: center;
            justify-content: center;

            text-align: center;

            padding: 100px 30px;
        }

        .lime-inner {
            max-width: 1050px;
        }

        .eyebrow {
            font-size: 13px;

            font-weight: 700;

            letter-spacing: 2px;

            color: #646d3d;

            margin-bottom: 26px;
        }

        .lime-title {
            font-family: Inter, sans-serif;

            font-size: clamp(52px, 5.3vw, 82px);

            line-height: 0.98;

            letter-spacing: -5px;

            font-weight: 800;
        }

        /* =========================================================
           MARQUEE
        ========================================================= */

        .marquee {
            height: 72px;

            background: #111111;

            color: white;

            overflow: hidden;

            border-top: 1px solid #333;
            border-bottom: 1px solid #333;

            display: flex;
            align-items: center;
        }

        .marquee-track {
            display: flex;

            width: max-content;

            animation: marquee 28s linear infinite;
        }

        .marquee-item {
            display: flex;
            align-items: center;
            gap: 45px;

            padding-right: 45px;

            font-size: 14px;
            font-weight: 700;

            white-space: nowrap;
        }

        .marquee-star {
            color: var(--lime);
            font-size: 17px;
        }

        @keyframes marquee {

            from {
                transform: translateX(0);
            }

            to {
                transform: translateX(-50%);
            }

        }

        /* =========================================================
           ATS SECTION
        ========================================================= */

        .ats-section {
            background: #fafaf8;

            padding: 150px 0;
        }

        .ats-grid {
            display: grid;

            grid-template-columns: 42% 58%;

            align-items: center;

            gap: 60px;
        }

        .section-title {
            font-family: Inter, sans-serif;

            font-size: clamp(55px, 5.3vw, 80px);

            line-height: 0.98;

            letter-spacing: -5px;

            font-weight: 800;
        }

        .section-description {
            max-width: 570px;

            margin-top: 30px;

            color: #737982;

            font-size: 18px;

            line-height: 1.65;
        }

        .check-list {
            margin-top: 32px;

            display: grid;

            gap: 16px;
        }

        .check {
            display: flex;

            align-items: center;

            gap: 13px;

            font-size: 15px;

            font-weight: 700;
        }

        .check-icon {
            width: 25px;
            height: 25px;

            border-radius: 50%;

            background: #111111;

            color: var(--lime);

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 13px;
        }

        /* ATS DASHBOARD MOCKUP */

        .ats-dashboard {
            background: #111111;

            border-radius: 25px;

            padding: 20px;

            box-shadow:
                0 30px 70px rgba(0,0,0,0.12);
        }

        .ats-window {
            border: 1px solid #343434;

            border-radius: 16px;

            padding: 30px;

            min-height: 300px;

            background:
                linear-gradient(
                    145deg,
                    #191919,
                    #111111
                );
        }

        .window-dots {
            display: flex;
            gap: 7px;
            margin-bottom: 25px;
        }

        .window-dots i {
            width: 8px;
            height: 8px;

            border-radius: 50%;

            background: #4c4c4c;
        }

        .ats-dashboard-inner {
            display: grid;

            grid-template-columns: 175px 1fr;

            gap: 20px;
        }

        .score-panel {
            background: #202020;

            border-radius: 15px;

            padding: 25px;

            text-align: center;
        }

        .big-score {
            width: 120px;
            height: 120px;

            margin: auto;

            border-radius: 50%;

            border: 10px solid #353535;
            border-right-color: var(--lime);
            border-bottom-color: var(--lime);
            border-left-color: var(--lime);

            display: flex;
            align-items: center;
            justify-content: center;

            color: white;

            font-size: 30px;

            font-weight: 700;
        }

        .score-panel p {
            margin-top: 14px;

            font-size: 12px;

            color: #888;
        }

        .keyword-list {
            display: grid;

            gap: 11px;
        }

        .keyword {
            min-height: 42px;

            padding: 0 15px;

            background: #202020;

            border-radius: 10px;

            display: flex;

            align-items: center;

            justify-content: space-between;

            color: white;

            font-size: 11px;
        }

        .keyword-left {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .keyword-dot {
            width: 7px;
            height: 7px;

            background: var(--lime);

            border-radius: 50%;
        }

        .keyword span:last-child {
            color: #777;
        }

        /* =========================================================
           HOW IT WORKS
        ========================================================= */

        .how-section {
            background: #fafaf8;

            padding: 110px 0 145px;

            border-top: 1px solid #ddd;
        }

        .how-title {
            max-width: 850px;
        }

        .steps {
            display: grid;

            grid-template-columns: repeat(3,1fr);

            margin-top: 70px;
        }

        .step {
            min-height: 290px;

            padding: 0 38px;

            border-right: 1px solid #d7d7d3;
        }

        .step:first-child {
            padding-left: 0;
        }

        .step:last-child {
            border-right: none;
        }

        .step-number {
            font-family: Inter, sans-serif;

            font-size: 56px;

            font-weight: 800;

            color: #c8c8c4;

            letter-spacing: -3px;
        }

        .step-title {
            font-family: Inter, sans-serif;

            font-size: 24px;

            margin-top: 48px;

            letter-spacing: -1px;
        }

        .step-text {
            color: #777d83;

            margin-top: 14px;

            max-width: 310px;

            line-height: 1.55;

            font-size: 15px;
        }

        /* =========================================================
           TEMPLATES
        ========================================================= */

        .templates-section {
            background: #fafaf8;

            padding: 90px 0 150px;
        }

        .templates-heading {
            display: flex;

            align-items: flex-end;

            justify-content: space-between;
        }

        .templates-title {
            max-width: 750px;
        }

        .view-all {
            border: 1px solid #d4d4d0;

            border-radius: 14px;

            padding: 15px 20px;

            font-size: 14px;

            font-weight: 700;

            transition: 0.25s ease;
        }

        .view-all:hover {
            background: #111;
            color: white;
        }

        .template-grid {
            display: grid;

            grid-template-columns: repeat(4,1fr);

            gap: 18px;

            margin-top: 55px;
        }

        .template-card {
            border: 1px solid #d8d8d4;

            border-radius: 16px;

            padding: 16px;

            background: #fff;

            transition: 0.3s ease;
        }

        .template-card:hover {
            transform: translateY(-8px);

            box-shadow:
                0 25px 55px rgba(0,0,0,0.08);
        }

        .template-preview {
            height: 395px;

            background: #f0f0ed;

            border-radius: 11px;

            padding: 18px;

            display: flex;

            justify-content: center;
        }

        .mini-resume {
            width: 100%;

            background: white;

            box-shadow: 0 4px 18px rgba(0,0,0,0.06);

            padding: 25px 20px;

            position: relative;

            overflow: hidden;
        }

        .mini-head {
            display: flex;

            align-items: center;

            gap: 12px;

            padding-bottom: 17px;

            border-bottom: 1px solid #222;
        }

        .mini-photo {
            width: 28px;
            height: 28px;

            border-radius: 50%;

            background: #d9d9d7;
        }

        .mini-head-lines {
            flex: 1;
        }

        .mini-name {
            height: 5px;

            width: 60%;

            background: #292929;

            border-radius: 3px;
        }

        .mini-sub {
            height: 4px;

            width: 42%;

            background: #d2d2cf;

            margin-top: 7px;

            border-radius: 3px;
        }

        .mini-columns {
            display: grid;

            grid-template-columns: 35% 65%;

            gap: 13px;

            margin-top: 20px;
        }

        .mini-sidebar {
            background: #f1f1ee;

            min-height: 230px;

            padding: 13px;
        }

        .mini-main {
            padding: 0 4px;
        }

        .mini-title {
            height: 5px;

            width: 42%;

            background: #333;

            margin-bottom: 9px;
        }

        .mini-line {
            height: 4px;

            width: 100%;

            background: #dededb;

            margin-bottom: 6px;

            border-radius: 3px;
        }

        .mini-line.short {
            width: 75%;
        }

        .template-card-footer {
            padding-top: 18px;
        }

        .template-name {
            font-size: 16px;

            font-weight: 700;
        }

        .template-desc {
            font-size: 12px;

            color: #888;

            margin-top: 4px;
        }

        .template-arrow {
            float: right;

            width: 29px;
            height: 29px;

            border-radius: 50%;

            background: #111;

            color: white;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 13px;
        }

        /* =========================================================
           DARK FEATURES
        ========================================================= */

        .features-section {
            background: #111111;

            color: white;

            padding: 130px 0 150px;
        }

        .features-section .eyebrow {
            color: #8e9a6b;
        }

        .features-title {
            max-width: 950px;
        }

        .features-description {
            margin-top: 25px;

            color: #92969a;

            max-width: 680px;

            font-size: 17px;

            line-height: 1.6;
        }

        .feature-grid {
            display: grid;

            grid-template-columns: repeat(3,1fr);

            margin-top: 70px;

            border-top: 1px solid #303030;

            border-left: 1px solid #303030;
        }

        .feature-card {
            min-height: 320px;

            padding: 35px;

            border-right: 1px solid #303030;

            border-bottom: 1px solid #303030;

            position: relative;
        }

        .feature-number {
            color: #8a8a8a;

            font-size: 12px;

            letter-spacing: 1px;
        }

        .feature-arrow {
            position: absolute;

            top: 35px;
            right: 35px;

            color: #888;
        }

        .feature-icon {
            margin-top: 58px;

            width: 48px;
            height: 48px;

            border-radius: 13px;

            background: #222222;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 20px;
        }

        .feature-title {
            font-size: 21px;

            font-weight: 700;

            margin-top: 25px;
        }

        .feature-text {
            color: #8c8c8c;

            line-height: 1.55;

            font-size: 14px;

            margin-top: 11px;

            max-width: 350px;
        }

        /* =========================================================
           FINAL CTA
        ========================================================= */

        .final-cta {
            background: var(--lime);

            padding: 145px 30px;

            text-align: center;
        }

        .final-title {
            font-family: Inter, sans-serif;

            font-size: clamp(55px, 7vw, 105px);

            line-height: 0.95;

            letter-spacing: -6px;

            font-weight: 800;

            max-width: 1100px;

            margin: auto;
        }

        .final-text {
            max-width: 580px;

            margin: 28px auto 0;

            font-size: 17px;

            color: #555d36;

            line-height: 1.6;
        }

        .final-button {
            display: inline-flex;

            margin-top: 35px;

            padding: 18px 28px;

            border-radius: 15px;

            background: #111111;

            color: white;

            font-weight: 700;

            transition: 0.25s ease;
        }

        .final-button:hover {
            transform: translateY(-3px);
        }

        /* =========================================================
           FOOTER
        ========================================================= */

        footer {
            background: #111111;

            color: white;

            padding: 65px 0 35px;
        }

        .footer-top {
            display: flex;

            justify-content: space-between;

            padding-bottom: 60px;

            border-bottom: 1px solid #303030;
        }

        .footer-brand {
            font-size: 25px;

            font-weight: 700;
        }

        .footer-tagline {
            color: #888;

            margin-top: 12px;

            max-width: 300px;

            line-height: 1.5;
        }

        .footer-links {
            display: flex;

            gap: 75px;
        }

        .footer-column strong {
            font-size: 13px;

            display: block;

            margin-bottom: 17px;
        }

        .footer-column a {
            display: block;

            color: #8a8a8a;

            font-size: 13px;

            margin-bottom: 10px;
        }

        .footer-column a:hover {
            color: white;
        }

        .footer-bottom {
            display: flex;

            justify-content: space-between;

            padding-top: 28px;

            color: #6e6e6e;

            font-size: 12px;
        }

        /* =========================================================
           REVEAL ANIMATION
        ========================================================= */

        .reveal {
            opacity: 0;

            transform: translateY(35px);

            transition:
                opacity 0.8s ease,
                transform 0.8s ease;
        }

        .reveal.visible {
            opacity: 1;

            transform: translateY(0);
        }

        /* =========================================================
           RESPONSIVE
        ========================================================= */

        @media(max-width: 1100px) {

            .nav-links {
                gap: 20px;
            }

            .nav-actions {
                margin-left: 30px;
            }

            .hero-inner {
                grid-template-columns: 1fr;
            }

            .hero {
                min-height: auto;
            }

            .hero-left {
                padding-top: 160px;
                padding-bottom: 30px;
            }

            .hero-right {
                height: 650px;
            }

            .resume-sheet {
                right: 8%;
            }

            .stats-grid {
                grid-template-columns: repeat(2,1fr);
            }

            .stat {
                border-bottom: 1px solid #333;
            }

            .ats-grid {
                grid-template-columns: 1fr;
            }

            .template-grid {
                grid-template-columns: repeat(2,1fr);
            }

        }

        @media(max-width: 760px) {

            .container {
                width: min(100% - 34px, 650px);
            }

            .navbar {
                width: calc(100% - 25px);
            }

            .nav-links {
                display: none;
            }

            .nav-actions {
                margin-left: auto;
            }

            .login-link {
                display: none;
            }

            .brand {
                font-size: 20px;
            }

            .hero-inner {
                width: calc(100% - 34px);
            }

            .hero-title {
                font-size: 64px;
                letter-spacing: -4px;
            }

            .hero-underline {
                width: 90%;
            }

            .hero-description {
                font-size: 16px;
            }

            .hero-right {
                height: 570px;
            }

            .resume-sheet {
                width: 420px;
                height: 540px;

                right: -5%;
                top: 60px;

                padding: 35px;
            }

            .ats-float {
                left: -5px;
                top: 150px;
            }

            .template-float {
                right: -15px;
                bottom: 55px;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .stat {
                border-right: none;

                padding-left: 30px;
            }

            .lime-title,
            .section-title,
            .features-title {
                letter-spacing: -3px;
            }

            .ats-dashboard-inner {
                grid-template-columns: 1fr;
            }

            .steps {
                grid-template-columns: 1fr;
            }

            .step {
                border-right: none;

                border-bottom: 1px solid #ddd;

                padding: 35px 0;
            }

            .step:first-child {
                padding-top: 0;
            }

            .template-grid {
                grid-template-columns: 1fr;
            }

            .templates-heading {
                display: block;
            }

            .view-all {
                display: inline-block;

                margin-top: 25px;
            }

            .feature-grid {
                grid-template-columns: 1fr;
            }

            .footer-top {
                display: block;
            }

            .footer-links {
                margin-top: 45px;

                display: grid;

                grid-template-columns: repeat(2,1fr);

                gap: 30px;
            }

            .footer-bottom {
                display: block;
            }

            .footer-bottom span {
                display: block;

                margin-top: 10px;
            }

        }

    </style>

</head>

<body>

<!-- =========================================================
     NAVIGATION
========================================================= -->

<div class="nav-wrap">

    <nav class="navbar">

        <a href="${pageContext.request.contextPath}/"
           class="brand">

            <div class="brand-icon">
                S
            </div>

            SmartResume

        </a>

        <div class="nav-links">

            <a href="#home">Home</a>

            <a href="#templates">Templates</a>

            <a href="#features">Features</a>

            <a href="#ats">ATS</a>

            <a href="#how">How it works</a>

        </div>

        <div class="nav-actions">

            <a class="login-link"
               href="${pageContext.request.contextPath}/login">
                Log in
            </a>

            <a class="create-btn"
               href="${pageContext.request.contextPath}/resume-builder">

                Create Resume

                <span>↗</span>

            </a>

        </div>

    </nav>

</div>


<!-- =========================================================
     HERO
========================================================= -->

<section class="hero" id="home">

    <div class="container hero-inner">

        <div class="hero-left reveal">

            <div class="hero-pill">

                <span class="hero-dot"></span>

                Your next opportunity starts here

            </div>

            <h1 class="hero-title">

                Build a<br>
                resume<br>
                worth<br>
                noticing.

            </h1>

            <div class="hero-underline"></div>

            <p class="hero-description">

                Create a polished, professional resume in minutes.
                Choose a design, tell your story, optimize it for ATS,
                and walk into your next application with confidence.

            </p>

            <div class="hero-buttons">

                <a class="hero-main-btn"
                   href="${pageContext.request.contextPath}/resume-builder">

                    Start building ↗

                </a>

                <a class="hero-secondary-btn"
                   href="#templates">

                    Explore templates ↓

                </a>

            </div>

            <div class="audience">

                <div class="avatars">

                    <div class="avatar a">A</div>
                    <div class="avatar r">R</div>
                    <div class="avatar s">S</div>
                    <div class="avatar m">M</div>
                    <div class="avatar k">K</div>

                </div>

                <div class="audience-text">

                    <strong>Built for ambitious people.</strong>

                    <span>Students, developers & professionals.</span>

                </div>

            </div>

        </div>


        <!-- HERO VISUAL -->

        <div class="hero-right reveal">

            <div class="resume-sheet">

                <div class="photo-circle">
                    AM
                </div>

                <div class="resume-name">
                    ALEX MORGAN
                </div>

                <div class="resume-role">
                    PRODUCT DESIGNER
                </div>

                <div class="resume-line"></div>

                <div class="resume-contact">

                    <span>alex@email.com</span>
                    <span>•</span>
                    <span>New York</span>
                    <span>•</span>
                    <span>linkedin.com</span>

                </div>

                <div class="resume-section">

                    <div class="resume-section-title">
                        PROFILE
                    </div>

                    <div class="fake-line"></div>
                    <div class="fake-line medium"></div>
                    <div class="fake-line small"></div>

                </div>

                <div class="resume-section">

                    <div class="resume-section-title">
                        EXPERIENCE
                    </div>

                    <div class="fake-line"></div>
                    <div class="fake-line medium"></div>
                    <div class="fake-line small"></div>
                    <div class="fake-line short"></div>

                </div>

                <div class="resume-section">

                    <div class="resume-section-title">
                        SELECTED PROJECTS
                    </div>

                    <div class="fake-line medium"></div>
                    <div class="fake-line"></div>
                    <div class="fake-line small"></div>

                </div>

                <div class="resume-section">

                    <div class="resume-section-title">
                        EDUCATION
                    </div>

                    <div class="fake-line short"></div>
                    <div class="fake-line small"></div>

                </div>

            </div>


            <div class="ats-float">

                <div class="ats-top">

                    <span>ATS score</span>

                    <span class="ats-badge">
                        Great
                    </span>

                </div>

                <div class="ats-body">

                    <div class="score-circle">
                        88
                    </div>

                    <div>

                        <strong>Strong match</strong>

                        <p>
                            Your resume is ready for applications.
                        </p>

                    </div>

                </div>

            </div>


            <div class="template-float">

                <div class="template-header">

                    <span>Template</span>

                    <span class="new-badge">
                        New
                    </span>

                </div>

                <div class="template-mini">

                    <div class="template-side"></div>

                    <div class="template-lines">

                        <div class="fake-line short"></div>
                        <div class="fake-line"></div>
                        <div class="fake-line medium"></div>
                        <div class="fake-line small"></div>

                    </div>

                </div>

            </div>

        </div>

    </div>

</section>


<!-- =========================================================
     STATS
========================================================= -->

<section class="stats-section">

    <div class="container">

        <div class="stats-grid">

            <div class="stat">

                <div class="stat-number">
                    20<span>+</span>
                </div>

                <div class="stat-label">
                    Resume designs
                </div>

            </div>

            <div class="stat">

                <div class="stat-number">
                    100<span>%</span>
                </div>

                <div class="stat-label">
                    Customizable
                </div>

            </div>

            <div class="stat">

                <div class="stat-number">
                    24<span>/7</span>
                </div>

                <div class="stat-label">
                    Access to your resumes
                </div>

            </div>

            <div class="stat">

                <div class="stat-number">
                    ∞
                </div>

                <div class="stat-label">
                    Career possibilities
                </div>

            </div>

        </div>

    </div>

</section>


<!-- =========================================================
     LIME STATEMENT
========================================================= -->

<section class="lime-section reveal">

    <div class="lime-inner">

        <div class="eyebrow">
            YOUR NEXT CHAPTER
        </div>

        <h2 class="lime-title">

            Your resume shouldn't be<br>
            the reason you get<br>
            overlooked.

        </h2>

    </div>

</section>


<!-- =========================================================
     MARQUEE
========================================================= -->

<div class="marquee">

    <div class="marquee-track">

        <div class="marquee-item">

            <span class="marquee-star">✦</span>
            EASY TO CUSTOMIZE

            <span class="marquee-star">✦</span>
            BUILT FOR YOUR CAREER

            <span class="marquee-star">✦</span>
            ATS READY

            <span class="marquee-star">✦</span>
            PROFESSIONAL TEMPLATES

            <span class="marquee-star">✦</span>
            LIVE PREVIEW

            <span class="marquee-star">✦</span>
            EASY TO CUSTOMIZE

            <span class="marquee-star">✦</span>
            BUILT FOR YOUR CAREER

            <span class="marquee-star">✦</span>
            ATS READY

        </div>

        <div class="marquee-item">

            <span class="marquee-star">✦</span>
            EASY TO CUSTOMIZE

            <span class="marquee-star">✦</span>
            BUILT FOR YOUR CAREER

            <span class="marquee-star">✦</span>
            ATS READY

            <span class="marquee-star">✦</span>
            PROFESSIONAL TEMPLATES

            <span class="marquee-star">✦</span>
            LIVE PREVIEW

            <span class="marquee-star">✦</span>
            EASY TO CUSTOMIZE

        </div>

    </div>

</div>


<!-- =========================================================
     ATS SECTION
========================================================= -->

<section class="ats-section" id="ats">

    <div class="container ats-grid">

        <div class="reveal">

            <div class="eyebrow">
                BUILT FOR MODERN HIRING
            </div>

            <h2 class="section-title">

                Don't let a robot<br>
                reject your<br>
                resume.

            </h2>

            <p class="section-description">

                SmartResume helps you understand how your resume
                performs before you send it into the application
                black hole.

            </p>

            <div class="check-list">

                <div class="check">

                    <span class="check-icon">✓</span>

                    Keyword coverage

                </div>

                <div class="check">

                    <span class="check-icon">✓</span>

                    Section completeness

                </div>

                <div class="check">

                    <span class="check-icon">✓</span>

                    Job description matching

                </div>

                <div class="check">

                    <span class="check-icon">✓</span>

                    Actionable improvements

                </div>

            </div>

        </div>


        <div class="ats-dashboard reveal">

            <div class="ats-window">

                <div class="window-dots">

                    <i></i>
                    <i></i>
                    <i></i>

                </div>

                <div class="ats-dashboard-inner">

                    <div class="score-panel">

                        <div class="big-score">
                            89
                        </div>

                        <p>
                            Resume score
                        </p>

                    </div>


                    <div class="keyword-list">

                        <div class="keyword">

                            <div class="keyword-left">

                                <span class="keyword-dot"></span>

                                Java

                            </div>

                            <span>
                                matched
                            </span>

                        </div>

                        <div class="keyword">

                            <div class="keyword-left">

                                <span class="keyword-dot"></span>

                                SQL

                            </div>

                            <span>
                                matched
                            </span>

                        </div>

                        <div class="keyword">

                            <div class="keyword-left">

                                <span class="keyword-dot"></span>

                                Projects

                            </div>

                            <span>
                                strong
                            </span>

                        </div>

                        <div class="keyword">

                            <div class="keyword-left">

                                <span class="keyword-dot"></span>

                                Experience

                            </div>

                            <span>
                                complete
                            </span>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </div>

</section>


<!-- =========================================================
     HOW IT WORKS
========================================================= -->

<section class="how-section" id="how">

    <div class="container">

        <div class="eyebrow">
            THE SIMPLE WAY
        </div>

        <h2 class="section-title how-title">

            From blank page to job-ready.

        </h2>


        <div class="steps">

            <div class="step reveal">

                <div class="step-number">
                    01
                </div>

                <h3 class="step-title">
                    Add your story
                </h3>

                <p class="step-text">

                    Tell SmartResume about your experience,
                    education, projects, skills and achievements.

                </p>

            </div>


            <div class="step reveal">

                <div class="step-number">
                    02
                </div>

                <h3 class="step-title">
                    Shape the design
                </h3>

                <p class="step-text">

                    Pick a template and customize the layout,
                    typography, colors and sections.

                </p>

            </div>


            <div class="step reveal">

                <div class="step-number">
                    03
                </div>

                <h3 class="step-title">
                    Apply with confidence
                </h3>

                <p class="step-text">

                    Check your ATS readiness, polish your resume
                    and export your final version.

                </p>

            </div>

        </div>

    </div>

</section>


<!-- =========================================================
     TEMPLATES
========================================================= -->

<section class="templates-section" id="templates">

    <div class="container">

        <div class="templates-heading">

            <div>

                <h2 class="section-title templates-title">

                    One career. Many ways to<br>
                    present it.

                </h2>

            </div>

            <a href="${pageContext.request.contextPath}/resume-builder"
               class="view-all">

                View all templates →

            </a>

        </div>


        <div class="template-grid">


            <!-- MODERN -->

            <div class="template-card reveal">

                <div class="template-preview">

                    <div class="mini-resume">

                        <div class="mini-head">

                            <div class="mini-photo"></div>

                            <div class="mini-head-lines">

                                <div class="mini-name"></div>
                                <div class="mini-sub"></div>

                            </div>

                        </div>

                        <div class="mini-columns">

                            <div class="mini-sidebar">

                                <div class="mini-title"></div>

                                <div class="mini-line"></div>
                                <div class="mini-line short"></div>

                                <br>

                                <div class="mini-title"></div>

                                <div class="mini-line"></div>
                                <div class="mini-line short"></div>

                            </div>

                            <div class="mini-main">

                                <div class="mini-title"></div>

                                <div class="mini-line"></div>
                                <div class="mini-line"></div>
                                <div class="mini-line short"></div>

                                <br>

                                <div class="mini-title"></div>

                                <div class="mini-line"></div>
                                <div class="mini-line"></div>
                                <div class="mini-line short"></div>

                                <br>

                                <div class="mini-title"></div>

                                <div class="mini-line"></div>
                                <div class="mini-line"></div>

                            </div>

                        </div>

                    </div>

                </div>

                <div class="template-card-footer">

                    <span class="template-arrow">↗</span>

                    <div class="template-name">
                        Modern
                    </div>

                    <div class="template-desc">
                        Clean & balanced
                    </div>

                </div>

            </div>


            <!-- EXECUTIVE -->

            <div class="template-card reveal">

                <div class="template-preview">

                    <div class="mini-resume">

                        <div style="
                            height:65px;
                            background:#111;
                            margin:-25px -20px 20px;
                            padding:20px;
                        ">

                            <div style="
                                width:55%;
                                height:6px;
                                background:white;
                                border-radius:5px;
                            "></div>

                            <div style="
                                width:35%;
                                height:4px;
                                background:#777;
                                margin-top:8px;
                            "></div>

                        </div>

                        <div class="mini-columns">

                            <div class="mini-sidebar">

                                <div class="mini-title"></div>

                                <div class="mini-line"></div>
                                <div class="mini-line short"></div>

                                <br>

                                <div class="mini-title"></div>

                                <div class="mini-line"></div>
                                <div class="mini-line short"></div>

                            </div>

                            <div class="mini-main">

                                <div class="mini-title"></div>

                                <div class="mini-line"></div>
                                <div class="mini-line"></div>
                                <div class="mini-line short"></div>

                                <br>

                                <div class="mini-title"></div>

                                <div class="mini-line"></div>
                                <div class="mini-line"></div>
                                <div class="mini-line short"></div>

                            </div>

                        </div>

                    </div>

                </div>

                <div class="template-card-footer">

                    <span class="template-arrow">↗</span>

                    <div class="template-name">
                        Executive
                    </div>

                    <div class="template-desc">
                        Bold & corporate
                    </div>

                </div>

            </div>


            <!-- MINIMAL -->

            <div class="template-card reveal">

                <div class="template-preview">

                    <div class="mini-resume">

                        <div class="mini-head">

                            <div class="mini-photo"></div>

                            <div class="mini-head-lines">

                                <div class="mini-name"></div>
                                <div class="mini-sub"></div>

                            </div>

                        </div>

                        <div style="
                            margin-top:25px;
                        ">

                            <div class="mini-title"></div>

                            <div class="mini-line"></div>
                            <div class="mini-line"></div>
                            <div class="mini-line short"></div>

                            <br>

                            <div class="mini-title"></div>

                            <div class="mini-line"></div>
                            <div class="mini-line"></div>
                            <div class="mini-line"></div>

                            <br>

                            <div class="mini-title"></div>

                            <div class="mini-line"></div>
                            <div class="mini-line short"></div>

                            <br>

                            <div class="mini-title"></div>

                            <div class="mini-line"></div>
                            <div class="mini-line"></div>

                        </div>

                    </div>

                </div>

                <div class="template-card-footer">

                    <span class="template-arrow">↗</span>

                    <div class="template-name">
                        Minimal
                    </div>

                    <div class="template-desc">
                        Simple & elegant
                    </div>

                </div>

            </div>


            <!-- CREATIVE -->

            <div class="template-card reveal">

                <div class="template-preview">

                    <div class="mini-resume">

                        <div class="mini-head">

                            <div class="mini-photo"></div>

                            <div class="mini-head-lines">

                                <div class="mini-name"></div>
                                <div class="mini-sub"></div>

                            </div>

                        </div>

                        <div class="mini-columns">

                            <div class="mini-sidebar">

                                <div style="
                                    width:100%;
                                    height:5px;
                                    background:#111;
                                    margin-bottom:14px;
                                "></div>

                                <div class="mini-title"></div>

                                <div class="mini-line"></div>
                                <div class="mini-line short"></div>

                                <br>

                                <div class="mini-title"></div>

                                <div class="mini-line"></div>
                                <div class="mini-line"></div>

                            </div>

                            <div class="mini-main">

                                <div class="mini-title"></div>

                                <div class="mini-line"></div>
                                <div class="mini-line"></div>
                                <div class="mini-line short"></div>

                                <br>

                                <div class="mini-title"></div>

                                <div class="mini-line"></div>
                                <div class="mini-line"></div>

                                <br>

                                <div class="mini-title"></div>

                                <div class="mini-line"></div>
                                <div class="mini-line short"></div>

                            </div>

                        </div>

                    </div>

                </div>

                <div class="template-card-footer">

                    <span class="template-arrow">↗</span>

                    <div class="template-name">
                        Creative
                    </div>

                    <div class="template-desc">
                        Modern & expressive
                    </div>

                </div>

            </div>

        </div>

    </div>

</section>


<!-- =========================================================
     FEATURES
========================================================= -->

<section class="features-section" id="features">

    <div class="container">

        <div class="eyebrow">
            EVERYTHING YOU NEED
        </div>

        <h2 class="section-title features-title">

            Not another boring resume
            generator.

        </h2>

        <p class="features-description">

            SmartResume gives you the tools to build something
            that looks professional, reads clearly, and survives
            the first screening.

        </p>


        <div class="feature-grid">


            <div class="feature-card reveal">

                <div class="feature-number">
                    01
                </div>

                <div class="feature-arrow">
                    ↗
                </div>

                <div class="feature-icon">
                    ✦
                </div>

                <h3 class="feature-title">
                    Build visually
                </h3>

                <p class="feature-text">

                    Create your resume with a clean visual editor
                    and see changes instantly while you build.

                </p>

            </div>


            <div class="feature-card reveal">

                <div class="feature-number">
                    02
                </div>

                <div class="feature-arrow">
                    ↗
                </div>

                <div class="feature-icon">
                    ◈
                </div>

                <h3 class="feature-title">
                    ATS optimized
                </h3>

                <p class="feature-text">

                    Analyze your resume for keywords, missing
                    sections and common ATS problems before you apply.

                </p>

            </div>


            <div class="feature-card reveal">

                <div class="feature-number">
                    03
                </div>

                <div class="feature-arrow">
                    ↗
                </div>

                <div class="feature-icon">
                    ⌘
                </div>

                <h3 class="feature-title">
                    Make it yours
                </h3>

                <p class="feature-text">

                    Choose layouts, colors, typography and sections
                    without sacrificing professionalism.

                </p>

            </div>

        </div>

    </div>

</section>


<!-- =========================================================
     FINAL CTA
========================================================= -->

<section class="final-cta">

    <h2 class="final-title">

        Your next opportunity
        starts here.

    </h2>

    <p class="final-text">

        Build a resume that looks like you mean business.
        Pick a template, tell your story and get ready
        for what's next.

    </p>

    <a class="final-button"
       href="${pageContext.request.contextPath}/resume-builder">

        Create my resume ↗

    </a>

</section>


<!-- =========================================================
     FOOTER
========================================================= -->

<footer>

    <div class="container">

        <div class="footer-top">

            <div>

                <div class="footer-brand">
                    SmartResume
                </div>

                <div class="footer-tagline">

                    Build. Polish. Get noticed.

                </div>

            </div>


            <div class="footer-links">

                <div class="footer-column">

                    <strong>Product</strong>

                    <a href="#templates">
                        Templates
                    </a>

                    <a href="#features">
                        Features
                    </a>

                    <a href="#ats">
                        ATS
                    </a>

                </div>


                <div class="footer-column">

                    <strong>Company</strong>

                    <a href="#how">
                        How it works
                    </a>

                    <a href="${pageContext.request.contextPath}/login">
                        Log in
                    </a>

                    <a href="${pageContext.request.contextPath}/resume-builder">
                        Create Resume
                    </a>

                </div>

            </div>

        </div>


        <div class="footer-bottom">

            <span>
                © 2026 SmartResume. All rights reserved.
            </span>

            <span>
                Built for ambitious people.
            </span>

        </div>

    </div>

</footer>


<!-- =========================================================
     JAVASCRIPT
========================================================= -->

<script>

    /* ============================================
       SCROLL REVEAL
    ============================================ */

    const revealElements =
        document.querySelectorAll(".reveal");

    const revealObserver =
        new IntersectionObserver(
            (entries) => {

                entries.forEach(entry => {

                    if (entry.isIntersecting) {

                        entry.target.classList.add("visible");

                        revealObserver.unobserve(
                            entry.target
                        );

                    }

                });

            },
            {
                threshold: 0.12
            }
        );


    revealElements.forEach(element => {

        revealObserver.observe(element);

    });


    /* ============================================
       NAVBAR SHADOW ON SCROLL
    ============================================ */

    const navbar =
        document.querySelector(".navbar");


    window.addEventListener(
        "scroll",
        () => {

            if (window.scrollY > 40) {

                navbar.style.boxShadow =
                    "0 15px 45px rgba(0,0,0,0.10)";

            } else {

                navbar.style.boxShadow =
                    "0 10px 35px rgba(0,0,0,0.045)";

            }

        }
    );


    /* ============================================
       SMOOTH ANCHOR SCROLL
    ============================================ */

    document.querySelectorAll(
        'a[href^="#"]'
    ).forEach(link => {

        link.addEventListener(
            "click",
            function(event) {

                const targetId =
                    this.getAttribute("href");

                if (
                    targetId &&
                    targetId !== "#"
                ) {

                    const target =
                        document.querySelector(
                            targetId
                        );

                    if (target) {

                        event.preventDefault();

                        target.scrollIntoView({
                            behavior: "smooth",
                            block: "start"
                        });

                    }

                }

            }
        );

    });

</script>

</body>
</html>