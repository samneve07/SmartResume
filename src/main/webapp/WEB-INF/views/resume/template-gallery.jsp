<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Templates — SmartResume</title>

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Manrope:wght@500;600;700;800&display=swap"
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
    font-family: "DM Sans", sans-serif;
    background: #f5f5f2;
    color: #111113;
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

    --black: #111113;
    --dark: #18181b;
    --muted: #6d6d73;
    --soft: #99999f;

    --line: #e2e2de;

    --lime: #d8ff63;

    --purple: #7257ff;

    --white: #ffffff;

}


/* =========================================================
   TOP NAV
========================================================= */

.topbar {

    height: 72px;

    background:
        rgba(255,255,255,.92);

    backdrop-filter: blur(20px);

    border-bottom:
        1px solid rgba(0,0,0,.07);

    display: flex;

    align-items: center;

    justify-content: space-between;

    padding: 0 38px;

    position: sticky;

    top: 0;

    z-index: 100;

}


.brand {

    display: flex;

    align-items: center;

    gap: 11px;

    font-family: "Manrope", sans-serif;

    font-size: 20px;

    font-weight: 800;

    letter-spacing: -.7px;

}


.brand-mark {

    width: 36px;
    height: 36px;

    border-radius: 10px;

    display: flex;

    align-items: center;

    justify-content: center;

    background: #111113;

    color: white;

    box-shadow:
        3px 3px 0 #d8ff63;

}


.nav-right {

    display: flex;

    align-items: center;

    gap: 10px;

}


.nav-link {

    padding: 10px 14px;

    border-radius: 10px;

    font-size: 13px;

    font-weight: 600;

    color: #66666b;

    transition: .2s ease;

}


.nav-link:hover {

    background: #f0f0ed;

    color: #111113;

}


.nav-btn {

    padding: 11px 17px;

    border-radius: 11px;

    background: #111113;

    color: white;

    font-size: 13px;

    font-weight: 700;

    transition: .25s ease;

}


.nav-btn:hover {

    transform: translateY(-2px);

    box-shadow:
        0 8px 20px rgba(0,0,0,.16);

}


.nav-btn span {

    color: var(--lime);

}


/* =========================================================
   HERO
========================================================= */

.hero {

    max-width: 1250px;

    margin: auto;

    padding:
        75px 28px 45px;

}


.eyebrow {

    display: inline-flex;

    align-items: center;

    gap: 8px;

    padding: 7px 11px;

    border:
        1px solid #ddddda;

    border-radius: 100px;

    background: white;

    color: #65656a;

    font-size: 11px;

    font-weight: 700;

}


.eyebrow-dot {

    width: 7px;
    height: 7px;

    border-radius: 50%;

    background: #a7d32d;

    box-shadow:
        0 0 0 4px rgba(167,211,45,.13);

}


.hero h1 {

    margin-top: 21px;

    font-family: "Manrope", sans-serif;

    font-size:
        clamp(42px, 6vw, 72px);

    line-height: .98;

    letter-spacing: -4px;

    max-width: 850px;

}


.hero h1 em {

    font-style: normal;

    position: relative;

}


.hero h1 em::after {

    content: "";

    position: absolute;

    left: 0;

    right: 0;

    bottom: -2px;

    height: 7px;

    background: var(--lime);

    z-index: -1;

}


.hero p {

    margin-top: 20px;

    max-width: 620px;

    color: #727278;

    font-size: 15px;

    line-height: 1.7;

}


/* =========================================================
   CATEGORY BAR
========================================================= */

.filters-wrap {

    max-width: 1250px;

    margin: auto;

    padding:
        0 28px 38px;

}


.filters {

    display: flex;

    gap: 8px;

    overflow-x: auto;

    scrollbar-width: none;

}


.filters::-webkit-scrollbar {
    display: none;
}


.filter-btn {

    flex-shrink: 0;

    border:
        1px solid #dcdcd7;

    background: white;

    color: #67676c;

    padding:
        10px 16px;

    border-radius: 100px;

    font-size: 12px;

    font-weight: 700;

    cursor: pointer;

    transition: .2s ease;

}


.filter-btn:hover {

    border-color: #bcbcb6;

    color: #111113;

}


.filter-btn.active {

    background: #111113;

    color: white;

    border-color: #111113;

}


/* =========================================================
   GALLERY
========================================================= */

.gallery {

    max-width: 1250px;

    margin: auto;

    padding:
        0 28px 110px;

}


.gallery-grid {

    display: grid;

    grid-template-columns:
        repeat(3, minmax(0,1fr));

    gap: 26px;

}


/* =========================================================
   TEMPLATE CARD
========================================================= */

.template-card {

    background: white;

    border:
        1px solid #deded9;

    border-radius: 18px;

    padding: 13px;

    position: relative;

    overflow: hidden;

    transition:
        transform .35s ease,
        box-shadow .35s ease,
        border-color .35s ease;

}


.template-card:hover {

    transform:
        translateY(-8px);

    border-color:
        #c8c8c2;

    box-shadow:
        0 24px 55px rgba(0,0,0,.11);

}


.preview-wrap {

    position: relative;

    border-radius: 11px;

    overflow: hidden;

    background: #ecece8;

}


.resume-preview {

    width: 100%;

    aspect-ratio: .707;

    background: white;

    overflow: hidden;

    position: relative;

    padding: 24px;

    transform-origin: center;

}


/* =========================================================
   HOVER ACTIONS
========================================================= */

.card-actions {

    position: absolute;

    inset: 0;

    display: flex;

    align-items: center;

    justify-content: center;

    gap: 8px;

    background:
        rgba(17,17,19,.43);

    opacity: 0;

    transition: .25s ease;

    backdrop-filter: blur(3px);

}


.template-card:hover .card-actions {

    opacity: 1;

}


.action-btn {

    border: 0;

    border-radius: 10px;

    padding:
        12px 16px;

    font-size: 12px;

    font-weight: 800;

    cursor: pointer;

    transition: .2s ease;

}


.preview-btn {

    background: white;

    color: #111113;

}


.use-btn {

    background: #d8ff63;

    color: #111113;

}


.action-btn:hover {

    transform:
        translateY(-2px);

}


/* =========================================================
   CARD INFO
========================================================= */

.card-info {

    display: flex;

    justify-content: space-between;

    align-items: center;

    padding:
        15px 4px 4px;

}


.card-name {

    font-family:
        "Manrope", sans-serif;

    font-size: 15px;

    font-weight: 800;

    letter-spacing: -.4px;

}


.card-description {

    margin-top: 3px;

    font-size: 10px;

    color: #88888d;

}


.card-category {

    font-size: 9px;

    font-weight: 800;

    color: #77777d;

    text-transform: uppercase;

    letter-spacing: .8px;

}


/* =========================================================
   GENERIC RESUME ELEMENTS
========================================================= */

.r-name {

    font-family: "Manrope", sans-serif;

    font-size: 24px;

    font-weight: 800;

    line-height: 1;

}


.r-role {

    margin-top: 5px;

    font-size: 8px;

    color: #777;

    font-weight: 700;

    text-transform: uppercase;

    letter-spacing: .7px;

}


.r-contact {

    margin-top: 9px;

    font-size: 6px;

    color: #777;

}


.r-section {

    margin-top: 17px;

}


.r-heading {

    font-size: 7px;

    font-weight: 800;

    text-transform: uppercase;

    letter-spacing: .8px;

    margin-bottom: 7px;

}


.r-line {

    height: 4px;

    border-radius: 4px;

    background: #e4e4e1;

    margin-bottom: 4px;

}


.r-line.dark {

    background: #bdbdb9;

}


.r-line.w1 {
    width: 95%;
}

.r-line.w2 {
    width: 82%;
}

.r-line.w3 {
    width: 66%;
}

.r-line.w4 {
    width: 48%;
}


.r-bullets {

    display: flex;

    flex-direction: column;

    gap: 4px;

}


.r-bullet {

    display: flex;

    gap: 5px;

    font-size: 5px;

    color: #777;

}


.r-bullet::before {

    content: "•";

    color: #333;

    font-size: 7px;

}


.r-tags {

    display: flex;

    flex-wrap: wrap;

    gap: 4px;

}


.r-tag {

    border:
        1px solid #d8d8d5;

    border-radius: 3px;

    padding:
        3px 5px;

    font-size: 5px;

    font-weight: 700;

}


/* =========================================================
   TEMPLATE 01 — APEX
========================================================= */

.t-apex {

    padding: 25px;

}


.t-apex .r-header {

    padding-bottom: 14px;

    border-bottom:
        2px solid #222;

}


.t-apex .r-name {

    font-size: 27px;

}


.t-apex .r-heading {

    color: #333;

    border-bottom:
        1px solid #aaa;

    padding-bottom: 4px;

}


/* =========================================================
   TEMPLATE 02 — NOVA
========================================================= */

.t-nova {

    padding: 0;

}


.t-nova .r-header {

    padding: 23px;

    background: #151515;

    color: white;

}


.t-nova .r-role {

    color: #aaa;

}


.t-nova .r-contact {

    color: #aaa;

}


.t-nova .r-content {

    padding: 0 23px 23px;

}


.t-nova .r-heading {

    color: #777;

}


/* =========================================================
   TEMPLATE 03 — VERTEX
========================================================= */

.t-vertex {

    padding: 0;

    display: grid;

    grid-template-columns: 32% 68%;

}


.t-vertex .r-sidebar {

    background: #1b1b1d;

    color: white;

    padding: 22px 15px;

}


.t-vertex .r-main {

    padding: 22px 19px;

}


.t-vertex .r-name {

    font-size: 18px;

}


.t-vertex .r-role {

    color: #aaa;

}


.t-vertex .r-heading {

    color: white;

    border-bottom:
        1px solid #555;

    padding-bottom: 5px;

}


.t-vertex .r-sidebar .r-line {

    background: #454549;

}


.t-vertex .r-sidebar .r-tag {

    border-color: #555;

    color: #ddd;

}


.t-vertex .r-main .r-heading {

    color: #222;

}


/* =========================================================
   TEMPLATE 04 — PULSE
========================================================= */

.t-pulse {

    padding: 22px;

}


.t-pulse .r-header {

    background: #e7ff99;

    margin:
        -22px -22px 0;

    padding: 22px;

}


.t-pulse .r-heading {

    color: #456000;

}


/* =========================================================
   TEMPLATE 05 — EXECUTIVE
========================================================= */

.t-executive {

    padding: 25px;

}


.t-executive .r-header {

    text-align: center;

    padding-bottom: 18px;

    border-bottom:
        4px solid #111;

}


.t-executive .r-contact {

    text-align: center;

}


.t-executive .r-heading {

    font-family: "Manrope";

    font-size: 8px;

}


/* =========================================================
   TEMPLATE 06 — PRESTIGE
========================================================= */

.t-prestige {

    padding: 0;

}


.t-prestige .r-header {

    background:
        #334155;

    color: white;

    padding: 25px;

}


.t-prestige .r-role {

    color: #cbd5e1;

}


.t-prestige .r-contact {

    color: #cbd5e1;

}


.t-prestige .r-content {

    padding: 0 24px 24px;

}


.t-prestige .r-heading {

    color: #334155;

}


/* =========================================================
   TEMPLATE 07 — CLARITY
========================================================= */

.t-clarity {

    padding: 27px;

}


.t-clarity .r-header {

    display: grid;

    grid-template-columns: 1fr 45px;

    gap: 15px;

    align-items: center;

}


.t-clarity .r-photo {

    width: 45px;
    height: 45px;

    border-radius: 50%;

    background: #ddd;

}


.t-clarity .r-heading {

    color: #3867a5;

    border-bottom:
        1px solid #3867a5;

    padding-bottom: 4px;

}


/* =========================================================
   TEMPLATE 08 — MONO
========================================================= */

.t-mono {

    padding: 28px;

}


.t-mono .r-header {

    border-left:
        6px solid #111;

    padding-left: 13px;

}


.t-mono .r-heading {

    font-size: 8px;

    letter-spacing: 1.2px;

}


/* =========================================================
   TEMPLATE 09 — VISION
========================================================= */

.t-vision {

    padding: 0;

    background:
        linear-gradient(
            135deg,
            #ffffff 0%,
            #f5f3ff 100%
        );

}


.t-vision .r-header {

    padding: 25px;

    background: #7257ff;

    color: white;

}


.t-vision .r-content {

    padding: 0 23px 23px;

}


.t-vision .r-heading {

    color: #7257ff;

}


/* =========================================================
   TEMPLATE 10 — CANVAS
========================================================= */

.t-canvas {

    padding: 0;

}


.t-canvas .r-header {

    padding: 22px;

    background:
        #f1f5f9;

    border-bottom:
        5px solid #111;

}


.t-canvas .r-content {

    padding: 0 22px 22px;

}


/* =========================================================
   TEMPLATE 11 — FUSION
========================================================= */

.t-fusion {

    padding: 0;

    display: grid;

    grid-template-columns: 36% 64%;

}


.t-fusion .r-sidebar {

    background: #dbeafe;

    padding: 20px 15px;

}


.t-fusion .r-main {

    padding: 20px 18px;

}


.t-fusion .r-heading {

    color: #2457a5;

}


/* =========================================================
   TEMPLATE 12 — BLOOM
========================================================= */

.t-bloom {

    padding: 24px;

}


.t-bloom .r-header {

    text-align: center;

}


.t-bloom .r-name {

    color: #8b5cf6;

}


.t-bloom .r-heading {

    color: #8b5cf6;

    text-align: center;

}


/* =========================================================
   TEMPLATE 13 — DEVCORE
========================================================= */

.t-devcore {

    background: #101114;

    color: #d8ff63;

    padding: 23px;

    font-family:
        monospace;

}


.t-devcore .r-role,
.t-devcore .r-contact {

    color: #8c8c93;

}


.t-devcore .r-heading {

    color: #d8ff63;

}


.t-devcore .r-line {

    background: #303136;

}


.t-devcore .r-line.dark {

    background: #52545b;

}


.t-devcore .r-tag {

    border-color: #404248;

}


/* =========================================================
   TEMPLATE 14 — STACK
========================================================= */

.t-stack {

    padding: 0;

}


.t-stack .r-header {

    padding: 24px;

    background: #0f172a;

    color: white;

    border-left:
        7px solid #22c55e;

}


.t-stack .r-content {

    padding: 0 22px 22px;

}


.t-stack .r-heading {

    color: #16a34a;

}


/* =========================================================
   TEMPLATE 15 — TERMINAL
========================================================= */

.t-terminal {

    background: #171717;

    color: #f5f5f5;

    padding: 22px;

    font-family:
        monospace;

}


.t-terminal .r-name {

    color: #4ade80;

}


.t-terminal .r-role,
.t-terminal .r-contact {

    color: #999;

}


.t-terminal .r-heading {

    color: #4ade80;

}


.t-terminal .r-line {

    background: #303030;

}


/* =========================================================
   TEMPLATE 16 — BYTE
========================================================= */

.t-byte {

    padding: 0;

    display: grid;

    grid-template-columns: 29% 71%;

}


.t-byte .r-sidebar {

    background:
        #172554;

    color: white;

    padding: 20px 13px;

}


.t-byte .r-main {

    padding: 20px 17px;

}


.t-byte .r-heading {

    color: #2563eb;

}


/* =========================================================
   TEMPLATE 17 — LAUNCH
========================================================= */

.t-launch {

    padding: 23px;

}


.t-launch .r-header {

    padding: 16px;

    background:
        #eff6ff;

    border-radius: 8px;

}


.t-launch .r-name {

    color: #1d4ed8;

}


.t-launch .r-heading {

    color: #1d4ed8;

}


/* =========================================================
   TEMPLATE 18 — FRESHER
========================================================= */

.t-fresher {

    padding: 25px;

}


.t-fresher .r-header {

    text-align: center;

}


.t-fresher .r-name {

    font-size: 26px;

}


.t-fresher .r-role {

    color: #2563eb;

}


.t-fresher .r-heading {

    background: #eff6ff;

    padding: 5px 7px;

    color: #1d4ed8;

}


/* =========================================================
   TEMPLATE 19 — ESSENTIAL
========================================================= */

.t-essential {

    padding: 28px;

}


.t-essential .r-header {

    border-bottom:
        1px solid #111;

    padding-bottom: 12px;

}


.t-essential .r-heading {

    font-size: 7px;

    letter-spacing: 1.4px;

}


/* =========================================================
   TEMPLATE 20 — ATS PRO
========================================================= */

.t-ats {

    padding: 24px;

}


.t-ats .r-header {

    padding-bottom: 13px;

    border-bottom:
        2px solid #2563eb;

}


.t-ats .r-name {

    color: #111;

}


.t-ats .r-heading {

    color: #2563eb;

}


.t-ats .r-tags .r-tag {

    border-radius: 10px;

}


/* =========================================================
   TEMPLATE 21 — CORPORATE
========================================================= */

.t-corporate {

    padding: 0;

}


.t-corporate .r-header {

    padding: 22px;

    background: #172554;

    color: white;

}


.t-corporate .r-content {

    padding: 0 22px 22px;

}


.t-corporate .r-heading {

    color: #172554;

    border-bottom:
        1px solid #cbd5e1;

    padding-bottom: 5px;

}


/* =========================================================
   TEMPLATE 22 — ORBIT
========================================================= */

.t-orbit {

    padding: 24px;

}


.t-orbit .r-header {

    display: flex;

    align-items: center;

    gap: 15px;

}


.t-orbit .r-photo {

    width: 55px;
    height: 55px;

    border-radius: 50%;

    background:
        #d8ff63;

}


.t-orbit .r-heading {

    color: #111;

    border-left:
        4px solid #d8ff63;

    padding-left: 7px;

}


/* =========================================================
   TEMPLATE 23 — ELEGANT
========================================================= */

.t-elegant {

    padding: 29px;

}


.t-elegant .r-header {

    text-align: center;

}


.t-elegant .r-name {

    font-family:
        Georgia,
        serif;

    font-weight: 500;

}


.t-elegant .r-heading {

    font-family:
        Georgia,
        serif;

    font-weight: 500;

    font-size: 9px;

}


/* =========================================================
   TEMPLATE 24 — BOLD
========================================================= */

.t-bold {

    padding: 0;

}


.t-bold .r-header {

    padding: 25px;

    background: #111113;

    color: white;

}


.t-bold .r-name {

    font-size: 31px;

}


.t-bold .r-content {

    padding: 0 24px 24px;

}


.t-bold .r-heading {

    background: #111113;

    color: white;

    padding: 5px 7px;

    display: inline-block;

}


/* =========================================================
   HIDDEN
========================================================= */

.template-card.hidden {

    display: none;

}


/* =========================================================
   EMPTY
========================================================= */

.no-results {

    display: none;

    text-align: center;

    padding: 80px;

    color: #777;

}


/* =========================================================
   FOOTER
========================================================= */

footer {

    background: #111113;

    color: white;

    padding: 35px 28px;

}


.footer-inner {

    max-width: 1250px;

    margin: auto;

    display: flex;

    justify-content: space-between;

    align-items: center;

}


.footer-copy {

    color: #77777d;

    font-size: 11px;

}


.footer-tag {

    color: #99999f;

    font-size: 11px;

}


/* =========================================================
   RESPONSIVE
========================================================= */

@media(max-width:1050px) {

    .gallery-grid {

        grid-template-columns:
            repeat(2,minmax(0,1fr));

    }

}


@media(max-width:680px) {

    .topbar {

        padding: 0 16px;

    }

    .nav-link {

        display: none;

    }

    .hero {

        padding-top: 50px;

    }

    .hero h1 {

        letter-spacing: -2.5px;

    }

    .gallery {

        padding-left: 14px;
        padding-right: 14px;

    }

    .filters-wrap {

        padding-left: 14px;
        padding-right: 14px;

    }

    .gallery-grid {

        grid-template-columns: 1fr;

        gap: 18px;

    }

    .resume-preview {

        aspect-ratio: .707;

    }

}


/* =========================================================
   MODAL
========================================================= */

.modal {

    position: fixed;

    inset: 0;

    background:
        rgba(0,0,0,.65);

    z-index: 500;

    display: none;

    align-items: center;

    justify-content: center;

    padding: 30px;

    backdrop-filter:
        blur(7px);

}


.modal.open {

    display: flex;

}


.modal-box {

    width: min(900px, 100%);

    max-height: 92vh;

    overflow: auto;

    background: #f5f5f2;

    border-radius: 20px;

    padding: 18px;

    position: relative;

}


.modal-close {

    position: absolute;

    top: 18px;

    right: 18px;

    width: 35px;
    height: 35px;

    border: 0;

    border-radius: 50%;

    background: #111113;

    color: white;

    cursor: pointer;

    z-index: 10;

}


.modal-title {

    font-family:
        "Manrope", sans-serif;

    font-size: 17px;

    font-weight: 800;

    padding: 8px 45px 15px 5px;

}


.modal-preview {

    background: white;

    display: flex;

    justify-content: center;

    padding: 25px;

    border-radius: 13px;

}


.modal-preview .resume-preview {

    width: 560px;

    max-width: 100%;

}


.modal-use {

    display: flex;

    justify-content: center;

    padding-top: 15px;

}


.modal-use a {

    background: #111113;

    color: white;

    padding: 13px 22px;

    border-radius: 11px;

    font-size: 13px;

    font-weight: 800;

}


.modal-use span {

    color: var(--lime);

}

</style>

</head>


<body>


<!-- =========================================================
     NAVIGATION
========================================================= -->

<header class="topbar">

    <a href="<%= ctx %>/"
       class="brand">

        <div class="brand-mark">
            S
        </div>

        SmartResume

    </a>


    <div class="nav-right">

        <a href="<%= ctx %>/"
           class="nav-link">
            Home
        </a>

        <a href="<%= ctx %>/dashboard"
           class="nav-link">
            Dashboard
        </a>

        <a href="<%= ctx %>/login"
           class="nav-btn">

            Create Resume
            <span>↗</span>

        </a>

    </div>

</header>



<!-- =========================================================
     HERO
========================================================= -->

<section class="hero">

    <div class="eyebrow">

        <span class="eyebrow-dot"></span>

        24 professional designs

    </div>


    <h1>

        Find a resume
        <em>that feels like you.</em>

    </h1>


    <p>

        Start with a professionally designed layout, then
        customize every detail with SmartResume's live builder.
        Switch templates anytime without rewriting your content.

    </p>

</section>



<!-- =========================================================
     FILTERS
========================================================= -->

<div class="filters-wrap">

    <div class="filters">

        <button class="filter-btn active"
                data-filter="all">
            All templates
        </button>

        <button class="filter-btn"
                data-filter="ats">
            ATS friendly
        </button>

        <button class="filter-btn"
                data-filter="modern">
            Modern
        </button>

        <button class="filter-btn"
                data-filter="executive">
            Executive
        </button>

        <button class="filter-btn"
                data-filter="creative">
            Creative
        </button>

        <button class="filter-btn"
                data-filter="tech">
            Tech
        </button>

        <button class="filter-btn"
                data-filter="student">
            Student
        </button>

        <button class="filter-btn"
                data-filter="photo">
            Photo
        </button>

    </div>

</div>



<!-- =========================================================
     GALLERY
========================================================= -->

<main class="gallery">

    <div class="gallery-grid">


        <!-- =================================================
             01 APEX
        ================================================== -->

        <article class="template-card"
                 data-category="executive ats">

            <div class="preview-wrap">

                <div class="resume-preview t-apex">

                    <div class="r-header">

                        <div class="r-name">
                            Alex Morgan
                        </div>

                        <div class="r-role">
                            Product Designer
                        </div>

                        <div class="r-contact">
                            alex@email.com &nbsp; • &nbsp;
                            New York &nbsp; • &nbsp;
                            linkedin.com/in/alex
                        </div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Professional Summary
                        </div>

                        <div class="r-line w1"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w2"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Experience
                        </div>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w3"></div>

                        <br>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w2"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Education
                        </div>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w3"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Skills
                        </div>

                        <div class="r-tags">

                            <span class="r-tag">Figma</span>
                            <span class="r-tag">UX</span>
                            <span class="r-tag">UI</span>
                            <span class="r-tag">Research</span>
                            <span class="r-tag">Strategy</span>

                        </div>

                    </div>

                </div>


                <div class="card-actions">

                    <button class="action-btn preview-btn"
                            data-preview="Apex">
                        Preview
                    </button>

                    <a class="action-btn use-btn"
                       href="<%= ctx %>/resume-builder?template=apex">
                        Use template →
                    </a>

                </div>

            </div>


            <div class="card-info">

                <div>

                    <div class="card-name">
                        Apex
                    </div>

                    <div class="card-description">
                        Sharp professional layout
                    </div>

                </div>

                <div class="card-category">
                    Executive
                </div>

            </div>

        </article>



        <!-- =================================================
             02 NOVA
        ================================================== -->

        <article class="template-card"
                 data-category="modern">

            <div class="preview-wrap">

                <div class="resume-preview t-nova">

                    <div class="r-header">

                        <div class="r-name">
                            Sarah Wilson
                        </div>

                        <div class="r-role">
                            Marketing Strategist
                        </div>

                        <div class="r-contact">
                            sarah@email.com • London • linkedin.com
                        </div>

                    </div>


                    <div class="r-content">

                        <div class="r-section">

                            <div class="r-heading">
                                Profile
                            </div>

                            <div class="r-line w1"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w3"></div>

                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Experience
                            </div>

                            <div class="r-line dark w2"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w2"></div>
                            <div class="r-line w3"></div>

                            <br>

                            <div class="r-line dark w2"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w3"></div>

                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Projects
                            </div>

                            <div class="r-line w1"></div>
                            <div class="r-line w2"></div>
                            <div class="r-line w3"></div>

                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Skills
                            </div>

                            <div class="r-tags">

                                <span class="r-tag">Strategy</span>
                                <span class="r-tag">SEO</span>
                                <span class="r-tag">Analytics</span>
                                <span class="r-tag">Branding</span>

                            </div>

                        </div>

                    </div>

                </div>


                <div class="card-actions">

                    <button class="action-btn preview-btn"
                            data-preview="Nova">
                        Preview
                    </button>

                    <a class="action-btn use-btn"
                       href="<%= ctx %>/resume-builder?template=nova">
                        Use template →
                    </a>

                </div>

            </div>


            <div class="card-info">

                <div>

                    <div class="card-name">
                        Nova
                    </div>

                    <div class="card-description">
                        Bold modern presentation
                    </div>

                </div>

                <div class="card-category">
                    Modern
                </div>

            </div>

        </article>



        <!-- =================================================
             03 VERTEX
        ================================================== -->

        <article class="template-card"
                 data-category="modern photo">

            <div class="preview-wrap">

                <div class="resume-preview t-vertex">

                    <aside class="r-sidebar">

                        <div class="r-photo"
                             style="width:52px;height:52px;border-radius:50%;background:#d8d8d8;margin-bottom:13px;">
                        </div>

                        <div class="r-name">
                            David Lee
                        </div>

                        <div class="r-role">
                            Software Engineer
                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Contact
                            </div>

                            <div class="r-line"></div>
                            <div class="r-line"></div>
                            <div class="r-line"></div>

                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Skills
                            </div>

                            <div class="r-line"></div>
                            <div class="r-line"></div>
                            <div class="r-line"></div>
                            <div class="r-line"></div>

                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Languages
                            </div>

                            <div class="r-line"></div>
                            <div class="r-line"></div>

                        </div>

                    </aside>


                    <div class="r-main">

                        <div class="r-section"
                             style="margin-top:0;">

                            <div class="r-heading">
                                Summary
                            </div>

                            <div class="r-line w1"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w2"></div>

                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Experience
                            </div>

                            <div class="r-line dark w2"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w2"></div>
                            <div class="r-line w3"></div>

                            <br>

                            <div class="r-line dark w2"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w3"></div>

                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Education
                            </div>

                            <div class="r-line dark w2"></div>
                            <div class="r-line w3"></div>

                        </div>

                    </div>

                </div>


                <div class="card-actions">

                    <button class="action-btn preview-btn"
                            data-preview="Vertex">
                        Preview
                    </button>

                    <a class="action-btn use-btn"
                       href="<%= ctx %>/resume-builder?template=vertex">
                        Use template →
                    </a>

                </div>

            </div>


            <div class="card-info">

                <div>

                    <div class="card-name">
                        Vertex
                    </div>

                    <div class="card-description">
                        Sidebar + photo
                    </div>

                </div>

                <div class="card-category">
                    Photo
                </div>

            </div>

        </article>



        <!-- =================================================
             04 PULSE
        ================================================== -->

        <article class="template-card"
                 data-category="modern creative">

            <div class="preview-wrap">

                <div class="resume-preview t-pulse">

                    <div class="r-header">

                        <div class="r-name">
                            Olivia Carter
                        </div>

                        <div class="r-role">
                            UX Designer
                        </div>

                        <div class="r-contact">
                            olivia@email.com • Toronto • portfolio.com
                        </div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            About
                        </div>

                        <div class="r-line w1"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w2"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Selected Experience
                        </div>

                        <div class="r-line dark w2"></div>

                        <div class="r-bullets">

                            <div class="r-bullet">
                                Led product redesign
                            </div>

                            <div class="r-bullet">
                                Improved conversion by 24%
                            </div>

                            <div class="r-bullet">
                                Built design system
                            </div>

                        </div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Education
                        </div>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w3"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Skills
                        </div>

                        <div class="r-tags">

                            <span class="r-tag">Figma</span>
                            <span class="r-tag">Prototyping</span>
                            <span class="r-tag">UX</span>
                            <span class="r-tag">Research</span>

                        </div>

                    </div>

                </div>


                <div class="card-actions">

                    <button class="action-btn preview-btn"
                            data-preview="Pulse">
                        Preview
                    </button>

                    <a class="action-btn use-btn"
                       href="<%= ctx %>/resume-builder?template=pulse">
                        Use template →
                    </a>

                </div>

            </div>


            <div class="card-info">

                <div>

                    <div class="card-name">
                        Pulse
                    </div>

                    <div class="card-description">
                        Fresh accent layout
                    </div>

                </div>

                <div class="card-category">
                    Creative
                </div>

            </div>

        </article>



        <!-- =================================================
             05 PRESTIGE
        ================================================== -->

        <article class="template-card"
                 data-category="executive">

            <div class="preview-wrap">

                <div class="resume-preview t-prestige">

                    <div class="r-header">

                        <div class="r-name">
                            Michael Brown
                        </div>

                        <div class="r-role">
                            Engineering Manager
                        </div>

                        <div class="r-contact">
                            michael@email.com • Chicago • linkedin.com
                        </div>

                    </div>


                    <div class="r-content">

                        <div class="r-section">

                            <div class="r-heading">
                                Professional Profile
                            </div>

                            <div class="r-line w1"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w2"></div>

                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Career History
                            </div>

                            <div class="r-line dark w2"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w3"></div>

                            <br>

                            <div class="r-line dark w2"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w2"></div>

                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Core Competencies
                            </div>

                            <div class="r-tags">

                                <span class="r-tag">Leadership</span>
                                <span class="r-tag">Cloud</span>
                                <span class="r-tag">Java</span>
                                <span class="r-tag">Architecture</span>

                            </div>

                        </div>

                    </div>

                </div>


                <div class="card-actions">

                    <button class="action-btn preview-btn"
                            data-preview="Prestige">
                        Preview
                    </button>

                    <a class="action-btn use-btn"
                       href="<%= ctx %>/resume-builder?template=prestige">
                        Use template →
                    </a>

                </div>

            </div>


            <div class="card-info">

                <div>

                    <div class="card-name">
                        Prestige
                    </div>

                    <div class="card-description">
                        Executive leadership
                    </div>

                </div>

                <div class="card-category">
                    Executive
                </div>

            </div>

        </article>



        <!-- =================================================
             06 CLARITY
        ================================================== -->

        <article class="template-card"
                 data-category="ats modern">

            <div class="preview-wrap">

                <div class="resume-preview t-clarity">

                    <div class="r-header">

                        <div>

                            <div class="r-name">
                                Emma Davis
                            </div>

                            <div class="r-role">
                                Business Analyst
                            </div>

                        </div>

                        <div class="r-photo"></div>

                    </div>


                    <div class="r-contact">
                        emma@email.com • Boston • linkedin.com
                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Professional Summary
                        </div>

                        <div class="r-line w1"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w2"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Experience
                        </div>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w3"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Skills
                        </div>

                        <div class="r-tags">

                            <span class="r-tag">SQL</span>
                            <span class="r-tag">Excel</span>
                            <span class="r-tag">Analytics</span>
                            <span class="r-tag">Python</span>

                        </div>

                    </div>

                </div>


                <div class="card-actions">

                    <button class="action-btn preview-btn"
                            data-preview="Clarity">
                        Preview
                    </button>

                    <a class="action-btn use-btn"
                       href="<%= ctx %>/resume-builder?template=clarity">
                        Use template →
                    </a>

                </div>

            </div>


            <div class="card-info">

                <div>

                    <div class="card-name">
                        Clarity
                    </div>

                    <div class="card-description">
                        ATS-first professional
                    </div>

                </div>

                <div class="card-category">
                    ATS
                </div>

            </div>

        </article>



        <!-- =================================================
             07 VISION
        ================================================== -->

        <article class="template-card"
                 data-category="creative modern">

            <div class="preview-wrap">

                <div class="resume-preview t-vision">

                    <div class="r-header">

                        <div class="r-name">
                            Priya Rao
                        </div>

                        <div class="r-role">
                            Product Manager
                        </div>

                        <div class="r-contact">
                            priya@email.com • Bengaluru • linkedin.com
                        </div>

                    </div>


                    <div class="r-content">

                        <div class="r-section">

                            <div class="r-heading">
                                Professional Summary
                            </div>

                            <div class="r-line w1"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w3"></div>

                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Experience
                            </div>

                            <div class="r-line dark w2"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w2"></div>
                            <div class="r-line w3"></div>

                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Projects
                            </div>

                            <div class="r-line dark w2"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w3"></div>

                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Skills
                            </div>

                            <div class="r-tags">

                                <span class="r-tag">Product</span>
                                <span class="r-tag">Agile</span>
                                <span class="r-tag">Strategy</span>

                            </div>

                        </div>

                    </div>

                </div>


                <div class="card-actions">

                    <button class="action-btn preview-btn"
                            data-preview="Vision">
                        Preview
                    </button>

                    <a class="action-btn use-btn"
                       href="<%= ctx %>/resume-builder?template=vision">
                        Use template →
                    </a>

                </div>

            </div>


            <div class="card-info">

                <div>

                    <div class="card-name">
                        Vision
                    </div>

                    <div class="card-description">
                        Creative statement layout
                    </div>

                </div>

                <div class="card-category">
                    Creative
                </div>

            </div>

        </article>



        <!-- =================================================
             08 DEVCORE
        ================================================== -->

        <article class="template-card"
                 data-category="tech modern">

            <div class="preview-wrap">

                <div class="resume-preview t-devcore">

                    <div class="r-name">
                        $ sameer.dev
                    </div>

                    <div class="r-role">
                        Software Developer
                    </div>

                    <div class="r-contact">
                        sameer@dev.io • github.com/sameer • Mumbai
                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            // about
                        </div>

                        <div class="r-line w1"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w3"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            // experience
                        </div>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w2"></div>

                        <br>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w3"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            // tech stack
                        </div>

                        <div class="r-tags">

                            <span class="r-tag">Java</span>
                            <span class="r-tag">Spring</span>
                            <span class="r-tag">SQL</span>
                            <span class="r-tag">Git</span>
                            <span class="r-tag">Docker</span>

                        </div>

                    </div>

                </div>


                <div class="card-actions">

                    <button class="action-btn preview-btn"
                            data-preview="DevCore">
                        Preview
                    </button>

                    <a class="action-btn use-btn"
                       href="<%= ctx %>/resume-builder?template=devcore">
                        Use template →
                    </a>

                </div>

            </div>


            <div class="card-info">

                <div>

                    <div class="card-name">
                        DevCore
                    </div>

                    <div class="card-description">
                        Developer portfolio CV
                    </div>

                </div>

                <div class="card-category">
                    Tech
                </div>

            </div>

        </article>



        <!-- =================================================
             09 STACK
        ================================================== -->

        <article class="template-card"
                 data-category="tech">

            <div class="preview-wrap">

                <div class="resume-preview t-stack">

                    <div class="r-header">

                        <div class="r-name">
                            Arjun Mehta
                        </div>

                        <div class="r-role">
                            Full Stack Engineer
                        </div>

                        <div class="r-contact">
                            arjun@email.com • Pune • github.com
                        </div>

                    </div>


                    <div class="r-content">

                        <div class="r-section">

                            <div class="r-heading">
                                Profile
                            </div>

                            <div class="r-line w1"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w2"></div>

                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Engineering Experience
                            </div>

                            <div class="r-line dark w2"></div>

                            <div class="r-bullets">

                                <div class="r-bullet">
                                    Built scalable APIs
                                </div>

                                <div class="r-bullet">
                                    Reduced response time
                                </div>

                                <div class="r-bullet">
                                    Automated deployments
                                </div>

                            </div>

                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Technology
                            </div>

                            <div class="r-tags">

                                <span class="r-tag">Java</span>
                                <span class="r-tag">React</span>
                                <span class="r-tag">Node</span>
                                <span class="r-tag">AWS</span>

                            </div>

                        </div>

                    </div>

                </div>


                <div class="card-actions">

                    <button class="action-btn preview-btn"
                            data-preview="Stack">
                        Preview
                    </button>

                    <a class="action-btn use-btn"
                       href="<%= ctx %>/resume-builder?template=stack">
                        Use template →
                    </a>

                </div>

            </div>


            <div class="card-info">

                <div>

                    <div class="card-name">
                        Stack
                    </div>

                    <div class="card-description">
                        Structured developer layout
                    </div>

                </div>

                <div class="card-category">
                    Tech
                </div>

            </div>

        </article>



        <!-- =================================================
             10 TERMINAL
        ================================================== -->

        <article class="template-card"
                 data-category="tech creative">

            <div class="preview-wrap">

                <div class="resume-preview t-terminal">

                    <div class="r-name">
                        > Riya Sharma
                    </div>

                    <div class="r-role">
                        AI / ML Engineer
                    </div>

                    <div class="r-contact">
                        riya@ai.dev • Bengaluru • github.com
                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            $ summary
                        </div>

                        <div class="r-line w1"></div>
                        <div class="r-line w1"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            $ projects
                        </div>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w3"></div>

                        <br>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w1"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            $ skills
                        </div>

                        <div class="r-tags">

                            <span class="r-tag">Python</span>
                            <span class="r-tag">TensorFlow</span>
                            <span class="r-tag">SQL</span>

                        </div>

                    </div>

                </div>


                <div class="card-actions">

                    <button class="action-btn preview-btn"
                            data-preview="Terminal">
                        Preview
                    </button>

                    <a class="action-btn use-btn"
                       href="<%= ctx %>/resume-builder?template=terminal">
                        Use template →
                    </a>

                </div>

            </div>


            <div class="card-info">

                <div>

                    <div class="card-name">
                        Terminal
                    </div>

                    <div class="card-description">
                        Dark developer aesthetic
                    </div>

                </div>

                <div class="card-category">
                    Tech
                </div>

            </div>

        </article>



        <!-- =================================================
             11 LAUNCH
        ================================================== -->

        <article class="template-card"
                 data-category="student modern">

            <div class="preview-wrap">

                <div class="resume-preview t-launch">

                    <div class="r-header">

                        <div class="r-name">
                            Sameer Neve
                        </div>

                        <div class="r-role">
                            IT Student • Developer
                        </div>

                        <div class="r-contact">
                            sameer@email.com • Mumbai • github.com
                        </div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Objective
                        </div>

                        <div class="r-line w1"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w3"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Education
                        </div>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w3"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Projects
                        </div>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w2"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Skills
                        </div>

                        <div class="r-tags">

                            <span class="r-tag">Java</span>
                            <span class="r-tag">MySQL</span>
                            <span class="r-tag">Python</span>
                            <span class="r-tag">Git</span>

                        </div>

                    </div>

                </div>


                <div class="card-actions">

                    <button class="action-btn preview-btn"
                            data-preview="Launch">
                        Preview
                    </button>

                    <a class="action-btn use-btn"
                       href="<%= ctx %>/resume-builder?template=launch">
                        Use template →
                    </a>

                </div>

            </div>


            <div class="card-info">

                <div>

                    <div class="card-name">
                        Launch
                    </div>

                    <div class="card-description">
                        Built for students & freshers
                    </div>

                </div>

                <div class="card-category">
                    Student
                </div>

            </div>

        </article>



        <!-- =================================================
             12 FRESHER
        ================================================== -->

        <article class="template-card"
                 data-category="student ats">

            <div class="preview-wrap">

                <div class="resume-preview t-fresher">

                    <div class="r-header">

                        <div class="r-name">
                            Neha Patel
                        </div>

                        <div class="r-role">
                            Computer Engineering Graduate
                        </div>

                        <div class="r-contact">
                            neha@email.com • Mumbai • linkedin.com
                        </div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Career Objective
                        </div>

                        <div class="r-line w1"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w2"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Education
                        </div>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w3"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Academic Projects
                        </div>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w2"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Technical Skills
                        </div>

                        <div class="r-tags">

                            <span class="r-tag">Java</span>
                            <span class="r-tag">Python</span>
                            <span class="r-tag">SQL</span>
                            <span class="r-tag">HTML</span>

                        </div>

                    </div>

                </div>


                <div class="card-actions">

                    <button class="action-btn preview-btn"
                            data-preview="Fresher">
                        Preview
                    </button>

                    <a class="action-btn use-btn"
                       href="<%= ctx %>/resume-builder?template=fresher">
                        Use template →
                    </a>

                </div>

            </div>


            <div class="card-info">

                <div>

                    <div class="card-name">
                        Fresher
                    </div>

                    <div class="card-description">
                        Clean graduate resume
                    </div>

                </div>

                <div class="card-category">
                    Student
                </div>

            </div>

        </article>



        <!-- =================================================
             13 ESSENTIAL
        ================================================== -->

        <article class="template-card"
                 data-category="ats">

            <div class="preview-wrap">

                <div class="resume-preview t-essential">

                    <div class="r-header">

                        <div class="r-name">
                            Daniel Smith
                        </div>

                        <div class="r-role">
                            Financial Analyst
                        </div>

                        <div class="r-contact">
                            daniel@email.com • Boston • linkedin.com
                        </div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Summary
                        </div>

                        <div class="r-line w1"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w2"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Professional Experience
                        </div>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w3"></div>

                        <br>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w3"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Education
                        </div>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w3"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Skills
                        </div>

                        <div class="r-tags">

                            <span class="r-tag">Excel</span>
                            <span class="r-tag">Finance</span>
                            <span class="r-tag">SQL</span>
                            <span class="r-tag">Power BI</span>

                        </div>

                    </div>

                </div>


                <div class="card-actions">

                    <button class="action-btn preview-btn"
                            data-preview="Essential">
                        Preview
                    </button>

                    <a class="action-btn use-btn"
                       href="<%= ctx %>/resume-builder?template=essential">
                        Use template →
                    </a>

                </div>

            </div>


            <div class="card-info">

                <div>

                    <div class="card-name">
                        Essential
                    </div>

                    <div class="card-description">
                        Straightforward ATS design
                    </div>

                </div>

                <div class="card-category">
                    ATS
                </div>

            </div>

        </article>



        <!-- =================================================
             14 ATS PRO
        ================================================== -->

        <article class="template-card"
                 data-category="ats">

            <div class="preview-wrap">

                <div class="resume-preview t-ats">

                    <div class="r-header">

                        <div class="r-name">
                            John Miller
                        </div>

                        <div class="r-role">
                            Operations Manager
                        </div>

                        <div class="r-contact">
                            john@email.com • Chicago • linkedin.com
                        </div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Professional Summary
                        </div>

                        <div class="r-line w1"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w2"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Experience
                        </div>

                        <div class="r-line dark w2"></div>

                        <div class="r-bullets">

                            <div class="r-bullet">
                                Increased operational efficiency
                            </div>

                            <div class="r-bullet">
                                Managed cross-functional teams
                            </div>

                            <div class="r-bullet">
                                Delivered measurable savings
                            </div>

                        </div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Skills
                        </div>

                        <div class="r-tags">

                            <span class="r-tag">Operations</span>
                            <span class="r-tag">Leadership</span>
                            <span class="r-tag">Analytics</span>

                        </div>

                    </div>

                </div>


                <div class="card-actions">

                    <button class="action-btn preview-btn"
                            data-preview="ATS Pro">
                        Preview
                    </button>

                    <a class="action-btn use-btn"
                       href="<%= ctx %>/resume-builder?template=ats">
                        Use template →
                    </a>

                </div>

            </div>


            <div class="card-info">

                <div>

                    <div class="card-name">
                        ATS Pro
                    </div>

                    <div class="card-description">
                        Recruiter-friendly structure
                    </div>

                </div>

                <div class="card-category">
                    ATS
                </div>

            </div>

        </article>



        <!-- =================================================
             15 CORPORATE
        ================================================== -->

        <article class="template-card"
                 data-category="executive">

            <div class="preview-wrap">

                <div class="resume-preview t-corporate">

                    <div class="r-header">

                        <div class="r-name">
                            William Jones
                        </div>

                        <div class="r-role">
                            Senior Business Leader
                        </div>

                        <div class="r-contact">
                            william@email.com • New York • linkedin.com
                        </div>

                    </div>


                    <div class="r-content">

                        <div class="r-section">

                            <div class="r-heading">
                                Executive Summary
                            </div>

                            <div class="r-line w1"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w2"></div>

                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Leadership Experience
                            </div>

                            <div class="r-line dark w2"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w2"></div>
                            <div class="r-line w3"></div>

                            <br>

                            <div class="r-line dark w2"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w3"></div>

                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Education
                            </div>

                            <div class="r-line dark w2"></div>
                            <div class="r-line w3"></div>

                        </div>

                    </div>

                </div>


                <div class="card-actions">

                    <button class="action-btn preview-btn"
                            data-preview="Corporate">
                        Preview
                    </button>

                    <a class="action-btn use-btn"
                       href="<%= ctx %>/resume-builder?template=corporate">
                        Use template →
                    </a>

                </div>

            </div>


            <div class="card-info">

                <div>

                    <div class="card-name">
                        Corporate
                    </div>

                    <div class="card-description">
                        Traditional executive profile
                    </div>

                </div>

                <div class="card-category">
                    Executive
                </div>

            </div>

        </article>



        <!-- =================================================
             16 ORBIT
        ================================================== -->

        <article class="template-card"
                 data-category="modern photo">

            <div class="preview-wrap">

                <div class="resume-preview t-orbit">

                    <div class="r-header">

                        <div class="r-photo"></div>

                        <div>

                            <div class="r-name">
                                Amelia Smith
                            </div>

                            <div class="r-role">
                                Software Development Manager
                            </div>

                            <div class="r-contact">
                                amelia@email.com • Sydney
                            </div>

                        </div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Professional Summary
                        </div>

                        <div class="r-line w1"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w2"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Experience
                        </div>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w3"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Skills
                        </div>

                        <div class="r-tags">

                            <span class="r-tag">Java</span>
                            <span class="r-tag">AWS</span>
                            <span class="r-tag">Leadership</span>
                            <span class="r-tag">Cloud</span>

                        </div>

                    </div>

                </div>


                <div class="card-actions">

                    <button class="action-btn preview-btn"
                            data-preview="Orbit">
                        Preview
                    </button>

                    <a class="action-btn use-btn"
                       href="<%= ctx %>/resume-builder?template=orbit">
                        Use template →
                    </a>

                </div>

            </div>


            <div class="card-info">

                <div>

                    <div class="card-name">
                        Orbit
                    </div>

                    <div class="card-description">
                        Photo-first modern resume
                    </div>

                </div>

                <div class="card-category">
                    Photo
                </div>

            </div>

        </article>



        <!-- =================================================
             17 ELEGANT
        ================================================== -->

        <article class="template-card"
                 data-category="creative">

            <div class="preview-wrap">

                <div class="resume-preview t-elegant">

                    <div class="r-header">

                        <div class="r-name">
                            Charlotte Davis
                        </div>

                        <div class="r-role">
                            Communications Director
                        </div>

                        <div class="r-contact">
                            charlotte@email.com • London • portfolio.com
                        </div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Profile
                        </div>

                        <div class="r-line w1"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w2"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Experience
                        </div>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w2"></div>

                        <br>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w3"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Education
                        </div>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w3"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Languages
                        </div>

                        <div class="r-tags">

                            <span class="r-tag">English</span>
                            <span class="r-tag">French</span>
                            <span class="r-tag">German</span>

                        </div>

                    </div>

                </div>


                <div class="card-actions">

                    <button class="action-btn preview-btn"
                            data-preview="Elegant">
                        Preview
                    </button>

                    <a class="action-btn use-btn"
                       href="<%= ctx %>/resume-builder?template=elegant">
                        Use template →
                    </a>

                </div>

            </div>


            <div class="card-info">

                <div>

                    <div class="card-name">
                        Elegant
                    </div>

                    <div class="card-description">
                        Editorial & refined
                    </div>

                </div>

                <div class="card-category">
                    Creative
                </div>

            </div>

        </article>



        <!-- =================================================
             18 BOLD
        ================================================== -->

        <article class="template-card"
                 data-category="modern creative">

            <div class="preview-wrap">

                <div class="resume-preview t-bold">

                    <div class="r-header">

                        <div class="r-name">
                            Marcus Taylor
                        </div>

                        <div class="r-role">
                            Creative Director
                        </div>

                        <div class="r-contact">
                            marcus@email.com • Los Angeles • portfolio.com
                        </div>

                    </div>


                    <div class="r-content">

                        <div class="r-section">

                            <div class="r-heading">
                                Profile
                            </div>

                            <div class="r-line w1"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w2"></div>

                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Experience
                            </div>

                            <div class="r-line dark w2"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w2"></div>
                            <div class="r-line w3"></div>

                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Selected Work
                            </div>

                            <div class="r-line dark w2"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w3"></div>

                        </div>

                    </div>

                </div>


                <div class="card-actions">

                    <button class="action-btn preview-btn"
                            data-preview="Bold">
                        Preview
                    </button>

                    <a class="action-btn use-btn"
                       href="<%= ctx %>/resume-builder?template=bold">
                        Use template →
                    </a>

                </div>

            </div>


            <div class="card-info">

                <div>

                    <div class="card-name">
                        Bold
                    </div>

                    <div class="card-description">
                        High-impact creative resume
                    </div>

                </div>

                <div class="card-category">
                    Creative
                </div>

            </div>

        </article>



        <!-- =================================================
             19 FUSION
        ================================================== -->

        <article class="template-card"
                 data-category="modern creative">

            <div class="preview-wrap">

                <div class="resume-preview t-fusion">

                    <aside class="r-sidebar">

                        <div class="r-name">
                            Emily
                        </div>

                        <div class="r-role">
                            Product Designer
                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Contact
                            </div>

                            <div class="r-line"></div>
                            <div class="r-line"></div>
                            <div class="r-line"></div>

                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Skills
                            </div>

                            <div class="r-line"></div>
                            <div class="r-line"></div>
                            <div class="r-line"></div>
                            <div class="r-line"></div>

                        </div>

                    </aside>


                    <div class="r-main">

                        <div class="r-section"
                             style="margin-top:0;">

                            <div class="r-heading">
                                Summary
                            </div>

                            <div class="r-line w1"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w3"></div>

                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Experience
                            </div>

                            <div class="r-line dark w2"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w2"></div>
                            <div class="r-line w3"></div>

                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Projects
                            </div>

                            <div class="r-line dark w2"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w3"></div>

                        </div>

                    </div>

                </div>


                <div class="card-actions">

                    <button class="action-btn preview-btn"
                            data-preview="Fusion">
                        Preview
                    </button>

                    <a class="action-btn use-btn"
                       href="<%= ctx %>/resume-builder?template=fusion">
                        Use template →
                    </a>

                </div>

            </div>


            <div class="card-info">

                <div>

                    <div class="card-name">
                        Fusion
                    </div>

                    <div class="card-description">
                        Two-column modern layout
                    </div>

                </div>

                <div class="card-category">
                    Modern
                </div>

            </div>

        </article>



        <!-- =================================================
             20 BYTES
        ================================================== -->

        <article class="template-card"
                 data-category="tech">

            <div class="preview-wrap">

                <div class="resume-preview t-byte">

                    <aside class="r-sidebar">

                        <div class="r-name">
                            BYTE
                        </div>

                        <div class="r-role">
                            Backend Engineer
                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Contact
                            </div>

                            <div class="r-line"></div>
                            <div class="r-line"></div>
                            <div class="r-line"></div>

                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Skills
                            </div>

                            <div class="r-line"></div>
                            <div class="r-line"></div>
                            <div class="r-line"></div>
                            <div class="r-line"></div>

                        </div>

                    </aside>


                    <div class="r-main">

                        <div class="r-section"
                             style="margin-top:0;">

                            <div class="r-heading">
                                Summary
                            </div>

                            <div class="r-line w1"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w2"></div>

                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Experience
                            </div>

                            <div class="r-line dark w2"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w2"></div>
                            <div class="r-line w3"></div>

                            <br>

                            <div class="r-line dark w2"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w3"></div>

                        </div>


                        <div class="r-section">

                            <div class="r-heading">
                                Projects
                            </div>

                            <div class="r-line dark w2"></div>
                            <div class="r-line w1"></div>
                            <div class="r-line w3"></div>

                        </div>

                    </div>

                </div>


                <div class="card-actions">

                    <button class="action-btn preview-btn"
                            data-preview="Byte">
                        Preview
                    </button>

                    <a class="action-btn use-btn"
                       href="<%= ctx %>/resume-builder?template=byte">
                        Use template →
                    </a>

                </div>

            </div>


            <div class="card-info">

                <div>

                    <div class="card-name">
                        Byte
                    </div>

                    <div class="card-description">
                        Technical two-column CV
                    </div>

                </div>

                <div class="card-category">
                    Tech
                </div>

            </div>

        </article>



        <!-- =================================================
             21 MONO
        ================================================== -->

        <article class="template-card"
                 data-category="ats">

            <div class="preview-wrap">

                <div class="resume-preview t-mono">

                    <div class="r-header">

                        <div class="r-name">
                            Robert Williams
                        </div>

                        <div class="r-role">
                            Senior Consultant
                        </div>

                        <div class="r-contact">
                            robert@email.com • Chicago • linkedin.com
                        </div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Summary
                        </div>

                        <div class="r-line w1"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w2"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Experience
                        </div>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w3"></div>

                        <br>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w3"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Education
                        </div>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w3"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Skills
                        </div>

                        <div class="r-tags">

                            <span class="r-tag">Consulting</span>
                            <span class="r-tag">Strategy</span>
                            <span class="r-tag">Analytics</span>

                        </div>

                    </div>

                </div>


                <div class="card-actions">

                    <button class="action-btn preview-btn"
                            data-preview="Mono">
                        Preview
                    </button>

                    <a class="action-btn use-btn"
                       href="<%= ctx %>/resume-builder?template=mono">
                        Use template →
                    </a>

                </div>

            </div>


            <div class="card-info">

                <div>

                    <div class="card-name">
                        Mono
                    </div>

                    <div class="card-description">
                        Ultra-clean ATS layout
                    </div>

                </div>

                <div class="card-category">
                    ATS
                </div>

            </div>

        </article>



        <!-- =================================================
             22 ORBIT PRO
        ================================================== -->

        <article class="template-card"
                 data-category="photo modern">

            <div class="preview-wrap">

                <div class="resume-preview t-orbit">

                    <div class="r-header">

                        <div class="r-photo"></div>

                        <div>

                            <div class="r-name">
                                Linda Miller
                            </div>

                            <div class="r-role">
                                Marketing Manager
                            </div>

                            <div class="r-contact">
                                linda@email.com • Seattle
                            </div>

                        </div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Profile
                        </div>

                        <div class="r-line w1"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w3"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Experience
                        </div>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w2"></div>
                        <div class="r-line w3"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Skills
                        </div>

                        <div class="r-tags">

                            <span class="r-tag">Marketing</span>
                            <span class="r-tag">Brand</span>
                            <span class="r-tag">SEO</span>

                        </div>

                    </div>

                </div>


                <div class="card-actions">

                    <button class="action-btn preview-btn"
                            data-preview="Orbit">
                        Preview
                    </button>

                    <a class="action-btn use-btn"
                       href="<%= ctx %>/resume-builder?template=orbit">
                        Use template →
                    </a>

                </div>

            </div>


            <div class="card-info">

                <div>

                    <div class="card-name">
                        Orbit
                    </div>

                    <div class="card-description">
                        Professional photo resume
                    </div>

                </div>

                <div class="card-category">
                    Photo
                </div>

            </div>

        </article>



        <!-- =================================================
             23 BLOOM
        ================================================== -->

        <article class="template-card"
                 data-category="creative student">

            <div class="preview-wrap">

                <div class="resume-preview t-bloom">

                    <div class="r-header">

                        <div class="r-name">
                            Ananya Shah
                        </div>

                        <div class="r-role">
                            UI / UX Designer
                        </div>

                        <div class="r-contact">
                            ananya@email.com • Mumbai • behance.net
                        </div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            About Me
                        </div>

                        <div class="r-line w1"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w2"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Experience
                        </div>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w2"></div>

                        <br>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w3"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Skills
                        </div>

                        <div class="r-tags">

                            <span class="r-tag">Figma</span>
                            <span class="r-tag">UI</span>
                            <span class="r-tag">UX</span>
                            <span class="r-tag">Branding</span>

                        </div>

                    </div>

                </div>


                <div class="card-actions">

                    <button class="action-btn preview-btn"
                            data-preview="Bloom">
                        Preview
                    </button>

                    <a class="action-btn use-btn"
                       href="<%= ctx %>/resume-builder?template=bloom">
                        Use template →
                    </a>

                </div>

            </div>


            <div class="card-info">

                <div>

                    <div class="card-name">
                        Bloom
                    </div>

                    <div class="card-description">
                        Friendly creative design
                    </div>

                </div>

                <div class="card-category">
                    Creative
                </div>

            </div>

        </article>



        <!-- =================================================
             24 MINIMAL
        ================================================== -->

        <article class="template-card"
                 data-category="ats modern student">

            <div class="preview-wrap">

                <div class="resume-preview t-essential">

                    <div class="r-header">

                        <div class="r-name">
                            Aarav Joshi
                        </div>

                        <div class="r-role">
                            Computer Engineering Student
                        </div>

                        <div class="r-contact">
                            aarav@email.com • Pune • github.com
                        </div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Profile
                        </div>

                        <div class="r-line w1"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w2"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Education
                        </div>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w3"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Projects
                        </div>

                        <div class="r-line dark w2"></div>
                        <div class="r-line w1"></div>
                        <div class="r-line w2"></div>
                        <div class="r-line w3"></div>

                    </div>


                    <div class="r-section">

                        <div class="r-heading">
                            Technical Skills
                        </div>

                        <div class="r-tags">

                            <span class="r-tag">Java</span>
                            <span class="r-tag">Python</span>
                            <span class="r-tag">SQL</span>
                            <span class="r-tag">Git</span>

                        </div>

                    </div>

                </div>


                <div class="card-actions">

                    <button class="action-btn preview-btn"
                            data-preview="Minimal">
                        Preview
                    </button>

                    <a class="action-btn use-btn"
                       href="<%= ctx %>/resume-builder?template=minimal">
                        Use template →
                    </a>

                </div>

            </div>


            <div class="card-info">

                <div>

                    <div class="card-name">
                        Minimal
                    </div>

                    <div class="card-description">
                        Simple, clean & focused
                    </div>

                </div>

                <div class="card-category">
                    ATS
                </div>

            </div>

        </article>


    </div>


    <div class="no-results">
        No templates found for this category.
    </div>

</main>



<!-- =========================================================
     PREVIEW MODAL
========================================================= -->

<div class="modal"
     id="templateModal">

    <div class="modal-box">

        <button class="modal-close"
                id="modalClose">
            ×
        </button>


        <div class="modal-title"
             id="modalTitle">

            Template Preview

        </div>


        <div class="modal-preview"
             id="modalPreview">

        </div>


        <div class="modal-use">

            <a id="modalUse"
               href="#">

                Use this template
                <span>→</span>

            </a>

        </div>

    </div>

</div>



<!-- =========================================================
     FOOTER
========================================================= -->

<footer>

    <div class="footer-inner">

        <div class="footer-copy">

            © 2026 SmartResume

        </div>

        <div class="footer-tag">

            Build. Polish. Get Hired.

        </div>

    </div>

</footer>



<script>

/* =========================================================
   FILTERS
========================================================= */

const filterButtons =
    document.querySelectorAll(".filter-btn");

const templateCards =
    document.querySelectorAll(".template-card");

const noResults =
    document.querySelector(".no-results");


filterButtons.forEach(function(button) {

    button.addEventListener("click", function() {

        filterButtons.forEach(function(btn) {

            btn.classList.remove("active");

        });

        button.classList.add("active");


        const filter =
            button.dataset.filter;


        let visibleCount = 0;


        templateCards.forEach(function(card) {

            const categories =
                card.dataset.category
                    .toLowerCase()
                    .split(" ");


            if (
                filter === "all" ||
                categories.includes(filter)
            ) {

                card.classList.remove("hidden");

                visibleCount++;

            } else {

                card.classList.add("hidden");

            }

        });


        if (visibleCount === 0) {

            noResults.style.display = "block";

        } else {

            noResults.style.display = "none";

        }

    });

});



/* =========================================================
   PREVIEW MODAL
========================================================= */

const modal =
    document.getElementById("templateModal");

const modalClose =
    document.getElementById("modalClose");

const modalTitle =
    document.getElementById("modalTitle");

const modalPreview =
    document.getElementById("modalPreview");

const modalUse =
    document.getElementById("modalUse");


document.querySelectorAll(".preview-btn")
    .forEach(function(button) {

        button.addEventListener(
            "click",
            function(event) {

                event.stopPropagation();


                const name =
                    button.dataset.preview;


                const card =
                    button.closest(".template-card");


                const preview =
                    card.querySelector(".resume-preview");


                const previewClone =
                    preview.cloneNode(true);


                previewClone.style.width =
                    "560px";


                modalTitle.textContent =
                    name + " — Template Preview";


                modalPreview.innerHTML = "";

                modalPreview.appendChild(
                    previewClone
                );


                const useLink =
                    card.querySelector(".use-btn");

                modalUse.href =
                    useLink.href;


                modal.classList.add("open");

                document.body.style.overflow =
                    "hidden";

            }
        );

    });



/* =========================================================
   CLOSE MODAL
========================================================= */

function closeModal() {

    modal.classList.remove("open");

    document.body.style.overflow =
        "";

}


modalClose.addEventListener(
    "click",
    closeModal
);


modal.addEventListener(
    "click",
    function(event) {

        if (
            event.target === modal
        ) {

            closeModal();

        }

    }
);


document.addEventListener(
    "keydown",
    function(event) {

        if (
            event.key === "Escape" &&
            modal.classList.contains("open")
        ) {

            closeModal();

        }

    }
);

</script>


</body>

</html>