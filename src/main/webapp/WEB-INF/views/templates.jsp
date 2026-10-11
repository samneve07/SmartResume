<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String contextPath = request.getContextPath();

    String fullName =
            (String) session.getAttribute("fullName");

    if (fullName == null || fullName.isBlank()) {
        fullName = "User";
    }
%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta
    name="viewport"
    content="width=device-width, initial-scale=1.0"
>

<title>
    SmartResume — Templates
</title>


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

    font-family:
        Inter,
        Segoe UI,
        Arial,
        sans-serif;

    background: #f4f4f0;

    color: #111;

    min-height: 100vh;
}


/* =========================================================
   APP
========================================================= */

.app {

    display: flex;

    min-height: 100vh;
}


/* =========================================================
   SIDEBAR
========================================================= */

.sidebar {

    width: 250px;

    position: fixed;

    top: 0;
    bottom: 0;
    left: 0;

    background: #111;

    color: #fff;

    padding: 25px 17px;

    z-index: 50;
}


.brand {

    display: flex;

    align-items: center;

    gap: 10px;

    padding:
        7px 10px
        28px;
}


.brand-mark {

    width: 35px;
    height: 35px;

    border-radius: 10px;

    background: #c8ff32;

    color: #111;

    display: grid;

    place-items: center;

    font-size: 16px;

    font-weight: 1000;
}


.brand-name {

    font-size: 18px;

    font-weight: 950;
}


.nav-label {

    margin:
        8px 10px
        10px;

    font-size: 9px;

    letter-spacing: 1.5px;

    color: #777;

    font-weight: 900;

    text-transform: uppercase;
}


.nav {

    display: grid;

    gap: 5px;
}


.nav a {

    text-decoration: none;

    color: #999;

    padding: 12px 13px;

    border-radius: 10px;

    font-size: 13px;

    font-weight: 750;

    display: flex;

    align-items: center;

    gap: 10px;

    transition:
        background .2s,
        color .2s;
}


.nav a:hover {

    background: #202020;

    color: #fff;
}


.nav a.active {

    background: #252525;

    color: #fff;

    box-shadow:
        inset 3px 0 #c8ff32;
}


.sidebar-bottom {

    position: absolute;

    left: 17px;
    right: 17px;

    bottom: 18px;
}


.sidebar-bottom a {

    display: block;

    text-decoration: none;

    color: #999;

    padding: 12px;

    font-size: 13px;

    font-weight: 700;
}


/* =========================================================
   MAIN
========================================================= */

.main {

    margin-left: 250px;

    width:
        calc(100% - 250px);

    padding:
        38px 48px 70px;
}


/* =========================================================
   TOP
========================================================= */

.top {

    display: flex;

    justify-content: space-between;

    align-items: flex-start;

    gap: 30px;

    margin-bottom: 35px;
}


.eyebrow {

    color: #999;

    font-size: 10px;

    font-weight: 900;

    letter-spacing: 1.8px;

    text-transform: uppercase;
}


.title {

    font-size: 46px;

    line-height: 1;

    letter-spacing: -2.5px;

    font-weight: 950;

    margin-top: 8px;
}


.subtitle {

    max-width: 620px;

    color: #777;

    font-size: 14px;

    line-height: 1.6;

    margin-top: 11px;
}


.user-pill {

    display: flex;

    align-items: center;

    gap: 10px;

    background: #fff;

    border:
        1px solid #e3e3dd;

    border-radius: 12px;

    padding: 9px 13px;

    font-size: 12px;

    font-weight: 800;
}


.user-dot {

    width: 30px;
    height: 30px;

    border-radius: 50%;

    background: #c8ff32;

    display: grid;

    place-items: center;

    font-weight: 950;
}


/* =========================================================
   FILTERS
========================================================= */

.filters {

    display: flex;

    flex-wrap: wrap;

    gap: 8px;

    margin-bottom: 30px;
}


.filter {

    border:
        1px solid #deded8;

    background: #fff;

    color: #666;

    border-radius: 999px;

    padding:
        9px 15px;

    font-size: 11px;

    font-weight: 850;

    cursor: pointer;

    transition:
        background .2s,
        color .2s,
        transform .2s;
}


.filter:hover {

    transform:
        translateY(-1px);

    color: #111;
}


.filter.active {

    background: #111;

    border-color: #111;

    color: #fff;
}


/* =========================================================
   GRID
========================================================= */

.template-grid {

    display: grid;

    grid-template-columns:
        repeat(
            4,
            minmax(0, 1fr)
        );

    gap: 22px;
}


/* =========================================================
   TEMPLATE CARD
========================================================= */

.template-card {

    background: #fff;

    border:
        1px solid #e1e1db;

    border-radius: 18px;

    overflow: hidden;

    transition:
        transform .25s ease,
        box-shadow .25s ease,
        border-color .25s ease;
}


.template-card:hover {

    transform:
        translateY(-6px);

    border-color: #ccc;

    box-shadow:
        0 22px 55px
        rgba(0,0,0,.10);
}


/* =========================================================
   PREVIEW AREA
========================================================= */

.preview {

    height: 355px;

    background:
        linear-gradient(
            135deg,
            #ededE8,
            #f7f7f4
        );

    display: flex;

    align-items: center;

    justify-content: center;

    padding: 25px;

    position: relative;

    overflow: hidden;
}


.preview-tag {

    position: absolute;

    top: 14px;
    left: 14px;

    z-index: 3;

    background: #111;

    color: #fff;

    padding:
        6px 9px;

    border-radius: 6px;

    font-size: 8px;

    font-weight: 950;

    letter-spacing: .5px;
}


.preview-tag.green {

    background: #c8ff32;

    color: #111;
}


/* =========================================================
   A4 PAPER
========================================================= */

.paper {

    width: 205px;

    height: 290px;

    background: #fff;

    box-shadow:
        0 18px 40px
        rgba(0,0,0,.18);

    position: relative;

    overflow: hidden;

    color: #111;

    transition:
        transform .3s ease;
}


.template-card:hover .paper {

    transform:
        scale(1.025);
}


/* =========================================================
   PAPER COMMON
========================================================= */

.paper-inner {

    padding: 19px;

    height: 100%;
}


.p-name {

    font-size: 15px;

    font-weight: 950;

    line-height: 1.05;
}


.p-role {

    font-size: 6px;

    color: #777;

    margin-top: 4px;
}


.p-contact {

    font-size: 5px;

    color: #888;

    margin-top: 7px;

    line-height: 1.5;
}


.p-section {

    margin-top: 12px;
}


.p-section-title {

    font-size: 6px;

    font-weight: 950;

    letter-spacing: 1px;

    margin-bottom: 5px;
}


.p-line {

    height: 3px;

    background: #dededb;

    margin: 4px 0;

    border-radius: 2px;
}


.p-line.short {

    width: 67%;
}


.p-line.tiny {

    width: 45%;
}


.p-chip-row {

    display: flex;

    flex-wrap: wrap;

    gap: 3px;
}


.p-chip {

    height: 10px;

    padding:
        2px 5px;

    border-radius: 5px;

    background: #eee;

    font-size: 4px;

    color: #555;
}


/* =========================================================
   MODERN
========================================================= */

.paper-modern {

    border-top:
        7px solid #111;
}


.paper-modern .p-name {

    font-size: 19px;

    letter-spacing: -1px;
}


.paper-modern .p-section-title {

    color: #111;

    border-bottom:
        1px solid #111;

    padding-bottom: 4px;
}


/* =========================================================
   SIDEBAR
========================================================= */

.paper-sidebar {

    display: grid;

    grid-template-columns:
        58px 1fr;

    padding: 0;
}


.paper-sidebar .side {

    background: #111;

    color: #fff;

    padding: 17px 8px;
}


.paper-sidebar .side .mini-circle {

    width: 27px;
    height: 27px;

    border-radius: 50%;

    background: #c8ff32;

    margin: 0 auto 12px;
}


.paper-sidebar .side-line {

    height: 3px;

    background: #555;

    margin: 5px 2px;

    border-radius: 2px;
}


.paper-sidebar .content {

    padding: 18px 12px;
}


.paper-sidebar .p-name {

    color: #111;

    font-size: 16px;
}


/* =========================================================
   CLASSIC
========================================================= */

.paper-classic {

    border-top:
        3px solid #111;
}


.paper-classic .paper-inner {

    text-align: center;

    padding:
        22px 18px;
}


.paper-classic .p-name {

    font-family:
        Georgia,
        serif;

    font-size: 18px;
}


.paper-classic .p-role {

    font-family:
        Georgia,
        serif;
}


.paper-classic .p-section {

    text-align: left;
}


.paper-classic .p-section-title {

    border-bottom:
        1px solid #222;

    padding-bottom: 3px;
}


/* =========================================================
   MINIMAL
========================================================= */

.paper-minimal .paper-inner {

    padding:
        24px 22px;
}


.paper-minimal .p-name {

    font-size: 20px;

    font-weight: 700;

    letter-spacing: -1px;
}


.paper-minimal .p-section-title {

    font-size: 5px;

    color: #777;

    letter-spacing: 1.5px;
}


/* =========================================================
   EXECUTIVE
========================================================= */

.paper-executive {

    border-left:
        8px solid #111;
}


.paper-executive .p-name {

    font-size: 18px;
}


.paper-executive .p-role {

    color: #111;

    font-weight: 800;
}


.paper-executive .p-section-title {

    color: #111;

    border-bottom:
        2px solid #111;

    padding-bottom: 3px;
}


/* =========================================================
   CREATIVE
========================================================= */

.paper-creative {

    border-radius: 0;
}


.paper-creative::before {

    content: "";

    position: absolute;

    width: 95px;
    height: 95px;

    border-radius: 50%;

    background: #c8ff32;

    right: -32px;
    top: -32px;
}


.paper-creative::after {

    content: "";

    position: absolute;

    width: 55px;
    height: 55px;

    border-radius: 50%;

    background: #7c3aed;

    right: 25px;
    bottom: 35px;
}


.paper-creative .paper-inner {

    position: relative;

    z-index: 2;
}


.paper-creative .p-name {

    font-size: 20px;

    letter-spacing: -1px;
}


.paper-creative .p-section-title {

    color: #7c3aed;
}


/* =========================================================
   DEVELOPER
========================================================= */

.paper-developer {

    background: #101010;

    color: #fff;
}


.paper-developer .p-role,
.paper-developer .p-contact {

    color: #aaa;
}


.paper-developer .p-section-title {

    color: #c8ff32;
}


.paper-developer .p-line {

    background: #383838;
}


.paper-developer .p-chip {

    background: #202020;

    color: #c8ff32;

    border:
        1px solid #343434;
}


/* =========================================================
   CORPORATE
========================================================= */

.paper-corporate {

    border-top:
        40px solid #16213e;
}


.paper-corporate .paper-inner {

    padding-top: 5px;
}


.paper-corporate .p-name {

    font-size: 17px;

    color: #16213e;
}


.paper-corporate .p-section-title {

    color: #16213e;

    border-bottom:
        1px solid #16213e;

    padding-bottom: 4px;
}


/* =========================================================
   CARD INFO
========================================================= */

.info {

    padding:
        17px 17px 18px;
}


.info-top {

    display: flex;

    justify-content: space-between;

    gap: 10px;

    align-items: flex-start;
}


.template-name {

    font-size: 16px;

    font-weight: 950;

    letter-spacing: -.4px;
}


.badge {

    background: #f0f0eb;

    color: #777;

    border-radius: 999px;

    padding:
        5px 8px;

    font-size: 8px;

    font-weight: 900;
}


.description {

    color: #888;

    font-size: 11px;

    line-height: 1.5;

    margin-top: 6px;

    min-height: 33px;
}


.features {

    display: flex;

    flex-wrap: wrap;

    gap: 5px;

    margin-top: 10px;
}


.feature {

    font-size: 8px;

    color: #666;

    background: #f5f5f1;

    padding:
        5px 7px;

    border-radius: 5px;

    font-weight: 800;
}


.actions {

    display: grid;

    grid-template-columns:
        1fr 1fr;

    gap: 7px;

    margin-top: 15px;
}


.action {

    text-align: center;

    text-decoration: none;

    border-radius: 8px;

    padding:
        10px 8px;

    font-size: 10px;

    font-weight: 900;

    border:
        1px solid #ddd;

    color: #111;

    background: #fff;

    transition:
        background .2s,
        color .2s;
}


.action:hover {

    background: #f2f2ee;
}


.action.primary {

    background: #111;

    color: #fff;

    border-color: #111;
}


.action.primary:hover {

    background: #c8ff32;

    color: #111;

    border-color: #c8ff32;
}


/* =========================================================
   RESPONSIVE
========================================================= */

@media(max-width:1200px) {

    .template-grid {

        grid-template-columns:
            repeat(
                3,
                minmax(0,1fr)
            );
    }

}


@media(max-width:900px) {

    .sidebar {

        width: 72px;
    }


    .brand-name,
    .nav-label,
    .nav a span,
    .sidebar-bottom span {

        display: none;
    }


    .main {

        margin-left: 72px;

        width:
            calc(100% - 72px);

        padding:
            28px 20px 50px;
    }


    .template-grid {

        grid-template-columns:
            repeat(
                2,
                minmax(0,1fr)
            );
    }

}


@media(max-width:620px) {

    .top {

        display: block;
    }


    .user-pill {

        margin-top: 18px;

        width: fit-content;
    }


    .title {

        font-size: 36px;
    }


    .template-grid {

        grid-template-columns: 1fr;
    }


    .preview {

        height: 375px;
    }

}


/* Screenshot-inspired 12-template gallery */
.reference-template-grid{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:22px;padding-bottom:42px}
.reference-card{background:#fff;border:1px solid #dedede;border-radius:14px;overflow:hidden;box-shadow:0 5px 20px rgba(0,0,0,.04);transition:transform .2s,box-shadow .2s}
.reference-card:hover{transform:translateY(-4px);box-shadow:0 14px 32px rgba(0,0,0,.12)}
.reference-card .ref-art{height:330px;padding:22px;background:#f4f4f4;display:flex;align-items:center;justify-content:center;overflow:hidden}
.ref-sheet{width:210px;height:286px;background:white;box-shadow:0 4px 14px #0002;position:relative;overflow:hidden;font:5px Arial,sans-serif;color:#222;display:grid;grid-template-columns:34% 66%;}
.ref-sheet .left{padding:10px 7px;background:#e8edf1}.ref-sheet .right{padding:12px 9px}.ref-sheet .name{font-size:12px;font-weight:900;line-height:1.05;margin:9px 0 4px}.ref-sheet .role{font-size:5px;letter-spacing:1px;margin-bottom:10px}.ref-sheet .sect{font-size:6px;font-weight:900;letter-spacing:.5px;margin:9px 0 4px;text-transform:uppercase}.ref-sheet .line{height:2px;background:#b8bdc3;margin:3px 0;width:94%}.ref-sheet .line.short{width:65%}.ref-sheet .line.tiny{width:45%}.ref-sheet .photo{width:55px;height:65px;background:#d8d8d8;border:2px solid #fff;border-radius:2px;margin:0 auto 7px}.ref-sheet .bar{height:8px;background:#333;margin:4px 0}.ref-sheet .bullet{height:2px;background:#aaa;margin:4px 0;width:85%}
.ref-01{grid-template-columns:58% 42%;background:#08103e;color:#fff;border-radius:6px}.ref-01 .left{background:#f7f8fc;color:#111;padding-top:38px;clip-path:polygon(0 0,100% 8%,100% 92%,0 100%)}.ref-01 .right{background:#08103e;color:white;padding-top:30px}.ref-01 .photo{border-radius:50%;width:60px;height:60px}
.ref-02{grid-template-columns:50% 50%;background:#f6f6e9}.ref-02 .left{order:0;background:#291c26;color:#fff;padding-top:70px}.ref-02 .right{order:1;background:#f6f6e9}.ref-02 .photo{width:65px;height:65px;border-radius:50%;margin-top:-42px}
.ref-03{grid-template-columns:43% 57%;background:#fff}.ref-03 .left{background:#f0ead2}.ref-03:before{content:'';position:absolute;top:0;left:0;right:0;height:24px;background:#ff8000;clip-path:polygon(0 0,100% 0,40% 100%,0 70%)}.ref-03 .photo{border-radius:50%;width:65px;height:65px;margin-top:18px}
.ref-04{grid-template-columns:43% 57%;background:#fff}.ref-04 .left{background:#b0c4ca}.ref-04 .photo{width:72px;height:82px;border-radius:0}
.ref-05{grid-template-columns:34% 66%;background:#f3f1eb;border:7px solid #e9e6dd}.ref-05 .left{background:#34596b;color:#fff}.ref-05 .right{background:white}.ref-05 .name{font-weight:400;font-size:13px}
.ref-06{grid-template-columns:50% 50%;background:#f3f3f3}.ref-06 .left{background:#806b5e;color:#fff}.ref-06 .right{background:#fff}.ref-06 .photo{width:72px;height:72px;border-radius:12px}
.ref-07{display:block;background:#d8d8d8;padding-top:46px}.ref-07 .left{display:none}.ref-07 .right{padding:8px 12px;display:grid;grid-template-columns:1fr 1fr;gap:4px}.ref-07 .photo{position:absolute;top:9px;left:12px;width:56px;height:65px;border-radius:12px}.ref-07 .name{position:absolute;top:15px;left:78px;color:white;font-size:11px}.ref-07 .role{position:absolute;top:31px;left:78px;color:white}.ref-07 .sect{background:#302735;color:white;border-radius:8px;padding:3px}
.ref-08{grid-template-columns:35% 65%;background:#fff}.ref-08 .left{background:#dfe7f0}.ref-08 .right{background:#fff}.ref-08 .photo{width:48px;height:48px;border-radius:50%}.ref-08 .name{font-size:10px}
.ref-09{grid-template-columns:40% 60%;background:#fff}.ref-09 .left{background:#e8edf6}.ref-09 .right{padding-top:4px}.ref-09 .photo{width:70px;height:68px;border-radius:50%}.ref-09 .name{font:16px Georgia,serif}
.ref-10{grid-template-columns:36% 64%;background:#fff}.ref-10 .left{background:#302d31;color:#fff}.ref-10 .left .sect{background:#f7f7f7;color:#222;border-radius:8px;text-align:center;padding:3px}.ref-10 .photo{width:53px;height:53px;border-radius:50%}
.ref-11{grid-template-columns:42% 58%;background:#fff}.ref-11 .left{background:#eee}.ref-11 .photo{width:66px;height:66px;border-radius:50%}.ref-11 .right .name{font-size:15px}
.ref-12{display:block;background:#fff;border-top:12px solid #292015}.ref-12 .left{position:absolute;left:0;top:90px;bottom:0;width:43%;background:#292015;color:white}.ref-12 .right{margin-left:43%;padding-top:95px}.ref-12 .photo{position:absolute;top:12px;left:15px;width:85px;height:85px;border-radius:50%;border:6px solid #efc9ad}.ref-12 .name{position:absolute;left:47%;top:25px;font-size:14px;color:#292015}
.ref-card-footer{padding:16px 18px;display:flex;align-items:center;justify-content:space-between;gap:10px}.ref-card-footer h3{font-size:15px;margin:0 0 4px}.ref-card-footer p{font-size:12px;color:#777;margin:0}.ref-actions{display:flex;gap:8px}.ref-actions a{font-size:12px;font-weight:700;border-radius:8px;padding:9px 11px;background:#111;color:#fff;white-space:nowrap}.ref-actions a.preview-link{background:#f1f1f1;color:#222}
@media(max-width:1050px){.reference-template-grid{grid-template-columns:repeat(2,minmax(0,1fr))}}
@media(max-width:650px){.reference-template-grid{grid-template-columns:1fr}.reference-card .ref-art{height:320px}}

</style>

</head>


<body>


<div class="app">


<!-- =====================================================
     SIDEBAR
====================================================== -->

<aside class="sidebar">


    <div class="brand">

        <div class="brand-mark">
            S
        </div>

        <div class="brand-name">
            SmartResume
        </div>

    </div>


    <div class="nav-label">
        Workspace
    </div>


    <nav class="nav">

        <a href="<%= contextPath %>/dashboard">

            <span>⌂</span>

            <span>
                Dashboard
            </span>

        </a>


        <a href="<%= contextPath %>/resume-builder">

            <span>＋</span>

            <span>
                Create Resume
            </span>

        </a>


        <a href="<%= contextPath %>/my-resumes">

            <span>▣</span>

            <span>
                My Resumes
            </span>

        </a>


        <a
            class="active"
            href="<%= contextPath %>/templates"
        >

            <span>✦</span>

            <span>
                Templates
            </span>

        </a>


        <a href="<%= contextPath %>/dashboard">

            <span>◈</span>

            <span>
                ATS Checker
            </span>

        </a>

    </nav>


    <div class="sidebar-bottom">

        <a href="<%= contextPath %>/logout">

            ↪

            <span>
                Logout
            </span>

        </a>

    </div>

</aside>


<!-- =====================================================
     MAIN
====================================================== -->

<main class="main">


    <section class="top">

        <div>

            <div class="eyebrow">
                Resume Studio
            </div>

            <h1 class="title">
                Choose your look.
            </h1>

            <p class="subtitle">

                Pick a professional design built for
                recruiters, ATS systems and modern
                hiring teams. Your content stays the
                same — only the presentation changes.

            </p>

        </div>


        <div class="user-pill">

            <div class="user-dot">
                <%= fullName.substring(0,1).toUpperCase() %>
            </div>

            <%= fullName %>

        </div>

    </section>


    <!-- FILTERS -->

    <div class="filters">

        <button
            class="filter active"
            onclick="filterTemplates('all', this)"
        >
            All Templates
        </button>

        <button
            class="filter"
            onclick="filterTemplates('ats', this)"
        >
            ATS Friendly
        </button>

        <button
            class="filter"
            onclick="filterTemplates('professional', this)"
        >
            Professional
        </button>

        <button
            class="filter"
            onclick="filterTemplates('creative', this)"
        >
            Creative
        </button>

        <button
            class="filter"
            onclick="filterTemplates('tech', this)"
        >
            Developer
        </button>

    </div>


    <!-- =================================================
         TEMPLATE GRID
    ================================================== -->

    <section class="reference-template-grid" id="templateGrid">
<article class="reference-card template-card" data-category="professional professional"><div class="ref-art"><div class="ref-sheet ref-01"><div class="left"><div class="photo"></div><div class="sect">Contact</div><div class="line"></div><div class="line short"></div><div class="sect">Skills</div><div class="line"></div><div class="line short"></div><div class="line"></div><div class="sect">Education</div><div class="line"></div></div><div class="right"><div class="name">YOUR NAME</div><div class="role">PROFESSIONAL TITLE</div><div class="sect">Profile</div><div class="line"></div><div class="line"></div><div class="line short"></div><div class="sect">Work Experience</div><div class="bullet"></div><div class="line"></div><div class="line short"></div><div class="bullet"></div><div class="line"></div><div class="sect">Education</div><div class="line"></div><div class="line short"></div><div class="sect">Projects</div><div class="line"></div></div></div></div><div class="ref-card-footer"><div><h3>01. Navy Wave</h3><p>Professional · A4 resume layout</p></div><div class="ref-actions"><a class="preview-link" href="<%= contextPath %>/resume-builder?template=template-01">Preview</a><a href="<%= contextPath %>/resume-builder?template=template-01">Use</a></div></div></article>
<article class="reference-card template-card" data-category="creative creative"><div class="ref-art"><div class="ref-sheet ref-02"><div class="left"><div class="photo"></div><div class="sect">Contact</div><div class="line"></div><div class="line short"></div><div class="sect">Skills</div><div class="line"></div><div class="line short"></div><div class="line"></div><div class="sect">Education</div><div class="line"></div></div><div class="right"><div class="name">YOUR NAME</div><div class="role">PROFESSIONAL TITLE</div><div class="sect">Profile</div><div class="line"></div><div class="line"></div><div class="line short"></div><div class="sect">Work Experience</div><div class="bullet"></div><div class="line"></div><div class="line short"></div><div class="bullet"></div><div class="line"></div><div class="sect">Education</div><div class="line"></div><div class="line short"></div><div class="sect">Projects</div><div class="line"></div></div></div></div><div class="ref-card-footer"><div><h3>02. Plum & Ivory</h3><p>Creative · A4 resume layout</p></div><div class="ref-actions"><a class="preview-link" href="<%= contextPath %>/resume-builder?template=template-02">Preview</a><a href="<%= contextPath %>/resume-builder?template=template-02">Use</a></div></div></article>
<article class="reference-card template-card" data-category="creative creative"><div class="ref-art"><div class="ref-sheet ref-03"><div class="left"><div class="photo"></div><div class="sect">Contact</div><div class="line"></div><div class="line short"></div><div class="sect">Skills</div><div class="line"></div><div class="line short"></div><div class="line"></div><div class="sect">Education</div><div class="line"></div></div><div class="right"><div class="name">YOUR NAME</div><div class="role">PROFESSIONAL TITLE</div><div class="sect">Profile</div><div class="line"></div><div class="line"></div><div class="line short"></div><div class="sect">Work Experience</div><div class="bullet"></div><div class="line"></div><div class="line short"></div><div class="bullet"></div><div class="line"></div><div class="sect">Education</div><div class="line"></div><div class="line short"></div><div class="sect">Projects</div><div class="line"></div></div></div></div><div class="ref-card-footer"><div><h3>03. Orange Geometry</h3><p>Creative · A4 resume layout</p></div><div class="ref-actions"><a class="preview-link" href="<%= contextPath %>/resume-builder?template=template-03">Preview</a><a href="<%= contextPath %>/resume-builder?template=template-03">Use</a></div></div></article>
<article class="reference-card template-card" data-category="professional professional"><div class="ref-art"><div class="ref-sheet ref-04"><div class="left"><div class="photo"></div><div class="sect">Contact</div><div class="line"></div><div class="line short"></div><div class="sect">Skills</div><div class="line"></div><div class="line short"></div><div class="line"></div><div class="sect">Education</div><div class="line"></div></div><div class="right"><div class="name">YOUR NAME</div><div class="role">PROFESSIONAL TITLE</div><div class="sect">Profile</div><div class="line"></div><div class="line"></div><div class="line short"></div><div class="sect">Work Experience</div><div class="bullet"></div><div class="line"></div><div class="line short"></div><div class="bullet"></div><div class="line"></div><div class="sect">Education</div><div class="line"></div><div class="line short"></div><div class="sect">Projects</div><div class="line"></div></div></div></div><div class="ref-card-footer"><div><h3>04. Teal Edge</h3><p>Professional · A4 resume layout</p></div><div class="ref-actions"><a class="preview-link" href="<%= contextPath %>/resume-builder?template=template-04">Preview</a><a href="<%= contextPath %>/resume-builder?template=template-04">Use</a></div></div></article>
<article class="reference-card template-card" data-category="professional professional"><div class="ref-art"><div class="ref-sheet ref-05"><div class="left"><div class="photo"></div><div class="sect">Contact</div><div class="line"></div><div class="line short"></div><div class="sect">Skills</div><div class="line"></div><div class="line short"></div><div class="line"></div><div class="sect">Education</div><div class="line"></div></div><div class="right"><div class="name">YOUR NAME</div><div class="role">PROFESSIONAL TITLE</div><div class="sect">Profile</div><div class="line"></div><div class="line"></div><div class="line short"></div><div class="sect">Work Experience</div><div class="bullet"></div><div class="line"></div><div class="line short"></div><div class="bullet"></div><div class="line"></div><div class="sect">Education</div><div class="line"></div><div class="line short"></div><div class="sect">Projects</div><div class="line"></div></div></div></div><div class="ref-card-footer"><div><h3>05. Slate Classic</h3><p>Professional · A4 resume layout</p></div><div class="ref-actions"><a class="preview-link" href="<%= contextPath %>/resume-builder?template=template-05">Preview</a><a href="<%= contextPath %>/resume-builder?template=template-05">Use</a></div></div></article>
<article class="reference-card template-card" data-category="creative creative"><div class="ref-art"><div class="ref-sheet ref-06"><div class="left"><div class="photo"></div><div class="sect">Contact</div><div class="line"></div><div class="line short"></div><div class="sect">Skills</div><div class="line"></div><div class="line short"></div><div class="line"></div><div class="sect">Education</div><div class="line"></div></div><div class="right"><div class="name">YOUR NAME</div><div class="role">PROFESSIONAL TITLE</div><div class="sect">Profile</div><div class="line"></div><div class="line"></div><div class="line short"></div><div class="sect">Work Experience</div><div class="bullet"></div><div class="line"></div><div class="line short"></div><div class="bullet"></div><div class="line"></div><div class="sect">Education</div><div class="line"></div><div class="line short"></div><div class="sect">Projects</div><div class="line"></div></div></div></div><div class="ref-card-footer"><div><h3>06. Warm Minimal</h3><p>Creative · A4 resume layout</p></div><div class="ref-actions"><a class="preview-link" href="<%= contextPath %>/resume-builder?template=template-06">Preview</a><a href="<%= contextPath %>/resume-builder?template=template-06">Use</a></div></div></article>
<article class="reference-card template-card" data-category="professional professional"><div class="ref-art"><div class="ref-sheet ref-07"><div class="left"><div class="photo"></div><div class="sect">Contact</div><div class="line"></div><div class="line short"></div><div class="sect">Skills</div><div class="line"></div><div class="line short"></div><div class="line"></div><div class="sect">Education</div><div class="line"></div></div><div class="right"><div class="name">YOUR NAME</div><div class="role">PROFESSIONAL TITLE</div><div class="sect">Profile</div><div class="line"></div><div class="line"></div><div class="line short"></div><div class="sect">Work Experience</div><div class="bullet"></div><div class="line"></div><div class="line short"></div><div class="bullet"></div><div class="line"></div><div class="sect">Education</div><div class="line"></div><div class="line short"></div><div class="sect">Projects</div><div class="line"></div></div></div></div><div class="ref-card-footer"><div><h3>07. Charcoal Split</h3><p>Professional · A4 resume layout</p></div><div class="ref-actions"><a class="preview-link" href="<%= contextPath %>/resume-builder?template=template-07">Preview</a><a href="<%= contextPath %>/resume-builder?template=template-07">Use</a></div></div></article>
<article class="reference-card template-card" data-category="ats-friendly ats"><div class="ref-art"><div class="ref-sheet ref-08"><div class="left"><div class="photo"></div><div class="sect">Contact</div><div class="line"></div><div class="line short"></div><div class="sect">Skills</div><div class="line"></div><div class="line short"></div><div class="line"></div><div class="sect">Education</div><div class="line"></div></div><div class="right"><div class="name">YOUR NAME</div><div class="role">PROFESSIONAL TITLE</div><div class="sect">Profile</div><div class="line"></div><div class="line"></div><div class="line short"></div><div class="sect">Work Experience</div><div class="bullet"></div><div class="line"></div><div class="line short"></div><div class="bullet"></div><div class="line"></div><div class="sect">Education</div><div class="line"></div><div class="line short"></div><div class="sect">Projects</div><div class="line"></div></div></div></div><div class="ref-card-footer"><div><h3>08. Blue Profile</h3><p>ATS Friendly · A4 resume layout</p></div><div class="ref-actions"><a class="preview-link" href="<%= contextPath %>/resume-builder?template=template-08">Preview</a><a href="<%= contextPath %>/resume-builder?template=template-08">Use</a></div></div></article>
<article class="reference-card template-card" data-category="professional professional"><div class="ref-art"><div class="ref-sheet ref-09"><div class="left"><div class="photo"></div><div class="sect">Contact</div><div class="line"></div><div class="line short"></div><div class="sect">Skills</div><div class="line"></div><div class="line short"></div><div class="line"></div><div class="sect">Education</div><div class="line"></div></div><div class="right"><div class="name">YOUR NAME</div><div class="role">PROFESSIONAL TITLE</div><div class="sect">Profile</div><div class="line"></div><div class="line"></div><div class="line short"></div><div class="sect">Work Experience</div><div class="bullet"></div><div class="line"></div><div class="line short"></div><div class="bullet"></div><div class="line"></div><div class="sect">Education</div><div class="line"></div><div class="line short"></div><div class="sect">Projects</div><div class="line"></div></div></div></div><div class="ref-card-footer"><div><h3>09. Elegant Serif</h3><p>Professional · A4 resume layout</p></div><div class="ref-actions"><a class="preview-link" href="<%= contextPath %>/resume-builder?template=template-09">Preview</a><a href="<%= contextPath %>/resume-builder?template=template-09">Use</a></div></div></article>
<article class="reference-card template-card" data-category="professional professional"><div class="ref-art"><div class="ref-sheet ref-10"><div class="left"><div class="photo"></div><div class="sect">Contact</div><div class="line"></div><div class="line short"></div><div class="sect">Skills</div><div class="line"></div><div class="line short"></div><div class="line"></div><div class="sect">Education</div><div class="line"></div></div><div class="right"><div class="name">YOUR NAME</div><div class="role">PROFESSIONAL TITLE</div><div class="sect">Profile</div><div class="line"></div><div class="line"></div><div class="line short"></div><div class="sect">Work Experience</div><div class="bullet"></div><div class="line"></div><div class="line short"></div><div class="bullet"></div><div class="line"></div><div class="sect">Education</div><div class="line"></div><div class="line short"></div><div class="sect">Projects</div><div class="line"></div></div></div></div><div class="ref-card-footer"><div><h3>10. Dark Sidebar</h3><p>Professional · A4 resume layout</p></div><div class="ref-actions"><a class="preview-link" href="<%= contextPath %>/resume-builder?template=template-10">Preview</a><a href="<%= contextPath %>/resume-builder?template=template-10">Use</a></div></div></article>
<article class="reference-card template-card" data-category="ats-friendly ats"><div class="ref-art"><div class="ref-sheet ref-11"><div class="left"><div class="photo"></div><div class="sect">Contact</div><div class="line"></div><div class="line short"></div><div class="sect">Skills</div><div class="line"></div><div class="line short"></div><div class="line"></div><div class="sect">Education</div><div class="line"></div></div><div class="right"><div class="name">YOUR NAME</div><div class="role">PROFESSIONAL TITLE</div><div class="sect">Profile</div><div class="line"></div><div class="line"></div><div class="line short"></div><div class="sect">Work Experience</div><div class="bullet"></div><div class="line"></div><div class="line short"></div><div class="bullet"></div><div class="line"></div><div class="sect">Education</div><div class="line"></div><div class="line short"></div><div class="sect">Projects</div><div class="line"></div></div></div></div><div class="ref-card-footer"><div><h3>11. Soft Grey</h3><p>ATS Friendly · A4 resume layout</p></div><div class="ref-actions"><a class="preview-link" href="<%= contextPath %>/resume-builder?template=template-11">Preview</a><a href="<%= contextPath %>/resume-builder?template=template-11">Use</a></div></div></article>
<article class="reference-card template-card" data-category="creative creative"><div class="ref-art"><div class="ref-sheet ref-12"><div class="left"><div class="photo"></div><div class="sect">Contact</div><div class="line"></div><div class="line short"></div><div class="sect">Skills</div><div class="line"></div><div class="line short"></div><div class="line"></div><div class="sect">Education</div><div class="line"></div></div><div class="right"><div class="name">YOUR NAME</div><div class="role">PROFESSIONAL TITLE</div><div class="sect">Profile</div><div class="line"></div><div class="line"></div><div class="line short"></div><div class="sect">Work Experience</div><div class="bullet"></div><div class="line"></div><div class="line short"></div><div class="bullet"></div><div class="line"></div><div class="sect">Education</div><div class="line"></div><div class="line short"></div><div class="sect">Projects</div><div class="line"></div></div></div></div><div class="ref-card-footer"><div><h3>12. Sand Signature</h3><p>Creative · A4 resume layout</p></div><div class="ref-actions"><a class="preview-link" href="<%= contextPath %>/resume-builder?template=template-12">Preview</a><a href="<%= contextPath %>/resume-builder?template=template-12">Use</a></div></div></article>
</section>

</main>


</div>


<script>

/* =========================================================
   FILTER TEMPLATES
========================================================= */

function filterTemplates(
    category,
    button
) {

    document
        .querySelectorAll(
            ".filter"
        )
        .forEach(
            function (item) {

                item.classList.remove(
                    "active"
                );

            }
        );


    button.classList.add(
        "active"
    );


    document
        .querySelectorAll(
            ".template-card"
        )
        .forEach(
            function (card) {

                if (
                    category === "all"
                ) {

                    card.style.display =
                        "";

                    return;
                }


                const categories =
                    card.dataset.category
                        .split(" ");


                card.style.display =
                    categories.includes(
                        category
                    )
                    ? ""
                    : "none";

            }
        );
}

</script>


</body>

</html>