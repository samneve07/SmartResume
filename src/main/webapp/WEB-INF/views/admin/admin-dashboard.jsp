<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String contextPath =
            request.getContextPath();

    Integer totalUsers =
            (Integer) request.getAttribute(
                    "totalUsers"
            );

    Integer totalResumes =
            (Integer) request.getAttribute(
                    "totalResumes"
            );

    Integer totalTemplates =
            (Integer) request.getAttribute(
                    "totalTemplates"
            );

    Integer recentUsers =
            (Integer) request.getAttribute(
                    "recentUsers"
            );


    if (totalUsers == null) totalUsers = 0;
    if (totalResumes == null) totalResumes = 0;
    if (totalTemplates == null) totalTemplates = 8;
    if (recentUsers == null) recentUsers = 0;
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
    SmartResume — Admin Dashboard
</title>


<style>

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}


body {

    font-family:
        Inter,
        Segoe UI,
        Arial,
        sans-serif;

    background: #f3f3ef;

    color: #111;

    min-height: 100vh;
}


.app {

    display: flex;

    min-height: 100vh;
}


/* SIDEBAR */

.sidebar {

    width: 245px;

    position: fixed;

    inset: 0 auto 0 0;

    background: #111;

    color: white;

    padding: 24px 16px;
}


.brand {

    display: flex;

    align-items: center;

    gap: 10px;

    padding:
        7px
        10px
        30px;
}


.logo {

    width: 35px;
    height: 35px;

    border-radius: 10px;

    background: #c8ff32;

    color: #111;

    display: grid;

    place-items: center;

    font-weight: 950;
}


.brand-name {

    font-weight: 900;

    font-size: 17px;
}


.admin-label {

    margin:
        0
        10px
        12px;

    color: #666;

    font-size: 9px;

    font-weight: 900;

    letter-spacing: 1.5px;

    text-transform: uppercase;
}


.nav {

    display: grid;

    gap: 5px;
}


.nav a {

    text-decoration: none;

    color: #888;

    padding: 12px 13px;

    border-radius: 10px;

    font-size: 12px;

    font-weight: 750;
}


.nav a:hover,
.nav a.active {

    background: #222;

    color: #fff;
}


.nav a.active {

    box-shadow:
        inset 3px 0 #c8ff32;
}


.logout {

    position: absolute;

    bottom: 20px;

    left: 25px;

    color: #777;

    text-decoration: none;

    font-size: 12px;
}


/* MAIN */

.main {

    margin-left: 245px;

    width:
        calc(100% - 245px);

    padding:
        38px
        45px
        60px;
}


.topbar {

    display: flex;

    justify-content: space-between;

    align-items: flex-end;

    margin-bottom: 35px;
}


.eyebrow {

    font-size: 10px;

    color: #999;

    font-weight: 900;

    letter-spacing: 1.5px;

    text-transform: uppercase;
}


h1 {

    margin-top: 5px;

    font-size: 39px;

    letter-spacing: -2px;

    font-weight: 950;
}


.subtitle {

    margin-top: 7px;

    color: #777;

    font-size: 13px;
}


.admin-badge {

    background: #111;

    color: #c8ff32;

    padding: 10px 13px;

    border-radius: 9px;

    font-size: 10px;

    font-weight: 900;
}


/* STATS */

.stats {

    display: grid;

    grid-template-columns:
        repeat(
            4,
            1fr
        );

    gap: 17px;

    margin-bottom: 25px;
}


.stat {

    background: white;

    border:
        1px solid #e4e4df;

    border-radius: 16px;

    padding: 21px;

    box-shadow:
        0 8px 25px
        rgba(0,0,0,.035);
}


.stat-label {

    color: #999;

    font-size: 10px;

    font-weight: 850;

    text-transform: uppercase;

    letter-spacing: .7px;
}


.stat-number {

    font-size: 30px;

    font-weight: 950;

    letter-spacing: -1px;

    margin-top: 8px;
}


.stat-note {

    color: #888;

    font-size: 10px;

    margin-top: 5px;
}


/* GRID */

.content-grid {

    display: grid;

    grid-template-columns:
        1.4fr
        .9fr;

    gap: 20px;
}


.panel {

    background: white;

    border:
        1px solid #e4e4df;

    border-radius: 17px;

    padding: 22px;
}


.panel-title {

    font-size: 15px;

    font-weight: 950;
}


.panel-sub {

    color: #999;

    font-size: 10px;

    margin-top: 4px;

    margin-bottom: 20px;
}


/* ACTIVITY */

.activity {

    display: grid;

    gap: 10px;
}


.activity-row {

    display: flex;

    align-items: center;

    justify-content: space-between;

    padding: 14px;

    background: #f7f7f4;

    border-radius: 10px;
}


.activity-left {

    display: flex;

    align-items: center;

    gap: 11px;
}


.activity-icon {

    width: 32px;
    height: 32px;

    border-radius: 9px;

    background: #111;

    color: #c8ff32;

    display: grid;

    place-items: center;

    font-size: 12px;
}


.activity-name {

    font-size: 11px;

    font-weight: 850;
}


.activity-description {

    font-size: 9px;

    color: #999;

    margin-top: 2px;
}


/* QUICK ACTIONS */

.quick {

    display: grid;

    gap: 10px;
}


.quick a {

    display: flex;

    justify-content: space-between;

    align-items: center;

    text-decoration: none;

    padding: 15px;

    border:
        1px solid #e5e5df;

    border-radius: 10px;

    color: #111;

    font-size: 11px;

    font-weight: 850;

    transition: .2s;
}


.quick a:hover {

    background: #111;

    color: white;
}


.quick span {

    color: #999;
}


/* RESPONSIVE */

@media(max-width:950px) {

    .stats {

        grid-template-columns:
            repeat(2,1fr);
    }


    .content-grid {

        grid-template-columns: 1fr;
    }

}


@media(max-width:700px) {

    .sidebar {

        width: 70px;

        padding:
            20px 8px;
    }


    .brand {

        justify-content: center;

        padding:
            7px
            0
            25px;
    }


    .brand-name,
    .admin-label,
    .nav span {

        display: none;
    }


    .nav a {

        text-align: center;

        padding: 13px;
    }


    .logout {

        left: 25px;
    }


    .main {

        margin-left: 70px;

        width:
            calc(100% - 70px);

        padding:
            25px 18px;
    }


    h1 {

        font-size: 30px;
    }

}

</style>

</head>


<body>


<div class="app">


<!-- SIDEBAR -->

<aside class="sidebar">


<div class="brand">

    <div class="logo">
        S
    </div>

    <div class="brand-name">
        SmartResume
    </div>

</div>


<div class="admin-label">
    Administration
</div>


<nav class="nav">


<a
    class="active"
    href="<%= contextPath %>/admin/dashboard"
>
    ◈
    <span>
        Overview
    </span>
</a>


<a
    href="<%= contextPath %>/admin/dashboard"
>
    ◎
    <span>
        Users
    </span>
</a>


<a
    href="<%= contextPath %>/my-resumes"
>
    ▣
    <span>
        Resumes
    </span>
</a>


<a
    href="<%= contextPath %>/templates"
>
    ✦
    <span>
        Templates
    </span>
</a>


<a
    href="<%= contextPath %>/admin/dashboard"
>
    ◌
    <span>
        Analytics
    </span>
</a>


</nav>


<a
    class="logout"
    href="<%= contextPath %>/logout"
>
    ← Exit
</a>


</aside>


<!-- MAIN -->

<main class="main">


<div class="topbar">


<div>

    <div class="eyebrow">
        Control Center
    </div>

    <h1>
        Admin Dashboard
    </h1>

    <div class="subtitle">
        Monitor your SmartResume platform.
    </div>

</div>


<div class="admin-badge">
    ADMINISTRATOR
</div>


</div>


<!-- STATS -->

<section class="stats">


<div class="stat">

    <div class="stat-label">
        Total Users
    </div>

    <div class="stat-number">
        <%= totalUsers %>
    </div>

    <div class="stat-note">
        Registered accounts
    </div>

</div>


<div class="stat">

    <div class="stat-label">
        Total Resumes
    </div>

    <div class="stat-number">
        <%= totalResumes %>
    </div>

    <div class="stat-note">
        Created by users
    </div>

</div>


<div class="stat">

    <div class="stat-label">
        Templates
    </div>

    <div class="stat-number">
        <%= totalTemplates %>
    </div>

    <div class="stat-note">
        Professional designs
    </div>

</div>


<div class="stat">

    <div class="stat-label">
        New Users
    </div>

    <div class="stat-number">
        <%= recentUsers %>
    </div>

    <div class="stat-note">
        Joined this week
    </div>

</div>


</section>


<!-- CONTENT -->

<section class="content-grid">


<div class="panel">


<div class="panel-title">
    Platform Overview
</div>

<div class="panel-sub">
    Current SmartResume activity
</div>


<div class="activity">


<div class="activity-row">

<div class="activity-left">

<div class="activity-icon">
    ◎
</div>

<div>

<div class="activity-name">
    User Accounts
</div>

<div class="activity-description">
    Registered users on the platform
</div>

</div>

</div>


<strong>
    <%= totalUsers %>
</strong>

</div>


<div class="activity-row">

<div class="activity-left">

<div class="activity-icon">
    ▣
</div>

<div>

<div class="activity-name">
    Resume Library
</div>

<div class="activity-description">
    Resumes created by users
</div>

</div>

</div>


<strong>
    <%= totalResumes %>
</strong>

</div>


<div class="activity-row">

<div class="activity-left">

<div class="activity-icon">
    ✦
</div>

<div>

<div class="activity-name">
    Template Library
</div>

<div class="activity-description">
    Available professional templates
</div>

</div>

</div>


<strong>
    <%= totalTemplates %>
</strong>

</div>


</div>

</div>


<div class="panel">


<div class="panel-title">
    Quick Actions
</div>

<div class="panel-sub">
    Manage the platform
</div>


<div class="quick">


<a href="<%= contextPath %>/templates">

    Template Library

    <span>
        →
    </span>

</a>


<a href="<%= contextPath %>/my-resumes">

    Resume Library

    <span>
        →
    </span>

</a>


<a href="<%= contextPath %>/dashboard">

    Customer Dashboard

    <span>
        →
    </span>

</a>


<a href="<%= contextPath %>/admin">

    Admin Login

    <span>
        →
    </span>

</a>


</div>

</div>


</section>


</main>


</div>


</body>

</html>