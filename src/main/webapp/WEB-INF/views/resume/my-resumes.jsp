<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.smartresume.dao.ResumeDAO.ResumeData" %>

<%
    String contextPath = request.getContextPath();

    String fullName =
            (String) session.getAttribute("fullName");

    if (fullName == null || fullName.isBlank()) {
        fullName = "User";
    }

    List<ResumeData> resumes =
            (List<ResumeData>) request.getAttribute("resumes");

    if (resumes == null) {
        resumes = java.util.Collections.emptyList();
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
    SmartResume — My Resumes
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

    background: #f4f4f0;

    color: #111;

    min-height: 100vh;
}


.app {

    display: flex;

    min-height: 100vh;
}


/* SIDEBAR */

.side {

    width: 245px;

    background: #111;

    color: #fff;

    padding: 24px 16px;

    position: fixed;

    inset: 0 auto 0 0;
}


.brand {

    display: flex;

    align-items: center;

    gap: 10px;

    font-weight: 900;

    font-size: 18px;

    padding: 8px 10px 28px;
}


.brandmark {

    width: 34px;

    height: 34px;

    border-radius: 10px;

    background: #c8ff32;

    color: #111;

    display: grid;

    place-items: center;

    font-weight: 1000;
}


.nav {

    display: grid;

    gap: 6px;
}


.nav a {

    color: #999;

    text-decoration: none;

    padding: 12px 13px;

    border-radius: 10px;

    font-size: 13px;

    font-weight: 700;
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


.bottom {

    position: absolute;

    left: 16px;

    right: 16px;

    bottom: 18px;
}


.bottom a {

    display: block;

    color: #999;

    text-decoration: none;

    padding: 12px;

    font-size: 13px;
}


/* MAIN */

.main {

    margin-left: 245px;

    width: calc(100% - 245px);

    padding: 38px 46px;
}


.top {

    display: flex;

    justify-content: space-between;

    align-items: center;

    margin-bottom: 30px;
}


.eyebrow {

    font-size: 11px;

    font-weight: 900;

    letter-spacing: 1.5px;

    color: #999;

    text-transform: uppercase;
}


.title {

    font-size: 40px;

    letter-spacing: -2px;

    font-weight: 950;

    margin-top: 5px;
}


.sub {

    color: #777;

    margin-top: 7px;

    font-size: 14px;
}


.create {

    background: #111;

    color: #fff;

    text-decoration: none;

    padding: 13px 18px;

    border-radius: 11px;

    font-size: 13px;

    font-weight: 900;
}


.create span {

    color: #c8ff32;

    font-size: 18px;

    margin-right: 6px;
}


/* GRID */

.grid {

    display: grid;

    grid-template-columns:
        repeat(
            auto-fill,
            minmax(280px, 1fr)
        );

    gap: 20px;
}


.card {

    background: #fff;

    border: 1px solid #e5e5df;

    border-radius: 18px;

    overflow: hidden;

    box-shadow:
        0 10px 30px
        rgba(0,0,0,.04);
}


.thumb {

    height: 250px;

    background: #e9e9e5;

    display: flex;

    align-items: center;

    justify-content: center;

    padding: 24px;
}


.paper {

    width: 150px;

    height: 212px;

    background: #fff;

    box-shadow:
        0 12px 30px
        rgba(0,0,0,.14);

    padding: 16px;

    color: #222;

    overflow: hidden;
}


.paper .bar {

    height: 26px;

    background: #111;

    margin:
        -16px
        -16px
        12px;
}


.paper h3 {

    font-size: 12px;

    margin-bottom: 4px;
}


.paper small {

    font-size: 6px;

    color: #888;
}


.paper .line {

    height: 4px;

    background: #ddd;

    margin: 9px 0;
}


.paper .accent {

    height: 3px;

    background: #c8ff32;

    margin: 8px 0;
}


/* CARD INFO */

.meta {

    padding: 17px;
}


.name {

    font-weight: 900;

    font-size: 16px;

    white-space: nowrap;

    overflow: hidden;

    text-overflow: ellipsis;
}


.updated {

    font-size: 11px;

    color: #999;

    margin-top: 5px;
}


.actions {

    display: flex;

    gap: 7px;

    margin-top: 14px;
}


.actions a,
.actions button {

    border: 1px solid #ddd;

    background: #fff;

    color: #111;

    text-decoration: none;

    border-radius: 8px;

    padding: 9px 11px;

    font-size: 11px;

    font-weight: 800;

    cursor: pointer;
}


.actions .primary {

    background: #111;

    color: #fff;

    border-color: #111;
}


.actions form {

    margin: 0;
}


/* EMPTY */

.empty {

    background: #fff;

    border: 1px dashed #ccc;

    border-radius: 18px;

    padding: 70px 30px;

    text-align: center;
}


.empty-icon {

    font-size: 40px;

    margin-bottom: 15px;
}


.empty h2 {

    font-size: 24px;
}


.empty p {

    color: #888;

    margin:
        8px 0
        22px;
}


/* RESPONSIVE */

@media(max-width:800px) {

    .side {

        width: 70px;

        padding:
            20px 8px;
    }


    .brand span,
    .nav a span,
    .bottom a span {

        display: none;
    }


    .main {

        margin-left: 70px;

        width:
            calc(100% - 70px);

        padding:
            25px 18px;
    }


    .title {

        font-size: 30px;
    }


    .top {

        align-items:
            flex-end;
    }


    .create {

        padding:
            10px 12px;
    }
}

</style>

</head>


<body>


<div class="app">


<!-- SIDEBAR -->

<aside class="side">

    <div class="brand">

        <div class="brandmark">
            S
        </div>

        <span>
            SmartResume
        </span>

    </div>


    <nav class="nav">

        <a
            href="<%= contextPath %>/dashboard"
        >
            ⌂
            <span>
                Dashboard
            </span>
        </a>


        <a
            href="<%= contextPath %>/resume-builder"
        >
            ＋
            <span>
                Create Resume
            </span>
        </a>


        <a
            class="active"
            href="<%= contextPath %>/my-resumes"
        >
            ▣
            <span>
                My Resumes
            </span>
        </a>


        <a
            href="<%= contextPath %>/dashboard"
        >
            ✦
            <span>
                Templates
            </span>
        </a>


        <a
            href="<%= contextPath %>/dashboard"
        >
            ◈
            <span>
                ATS Checker
            </span>
        </a>

    </nav>


    <div class="bottom">

        <a
            href="<%= contextPath %>/logout"
        >
            ↪
            <span>
                Logout
            </span>
        </a>

    </div>

</aside>


<!-- MAIN -->

<main class="main">


<div class="top">


<div>

    <div class="eyebrow">
        Workspace
    </div>


    <div class="title">
        My Resumes
    </div>


    <div class="sub">

        <%= resumes.size() %>

        saved resume<%= resumes.size() == 1 ? "" : "s" %>

        · Welcome,

        <%= fullName %>

    </div>

</div>


<a
    class="create"
    href="<%= contextPath %>/resume-builder"
>

    <span>
        ＋
    </span>

    Create Resume

</a>


</div>


<% if (resumes.isEmpty()) { %>


<div class="empty">

    <div class="empty-icon">
        ✦
    </div>


    <h2>
        Your resume library is empty.
    </h2>


    <p>
        Create your first professional resume
        and it will appear here automatically.
    </p>


    <a
        class="create"
        href="<%= contextPath %>/resume-builder"
    >
        Create my first resume
    </a>

</div>


<% } else { %>


<div class="grid">


<% for (ResumeData r : resumes) { %>


<div class="card">


<div class="thumb">

<div class="paper">

    <div class="bar"></div>


    <h3>

        <%=

        r.getFullName() == null ||
        r.getFullName().isBlank()

        ? "Your Name"

        : r.getFullName()

        %>

    </h3>


    <small>

        <%=

        r.getEmail() == null
        ? ""
        : r.getEmail()

        %>

    </small>


    <div class="accent"></div>


    <div class="line"></div>
    <div class="line"></div>
    <div class="line"></div>
    <div class="line"></div>

</div>

</div>


<div class="meta">


<div class="name">

    <%=

    r.getResumeTitle() == null ||
    r.getResumeTitle().isBlank()

    ? "My Resume"

    : r.getResumeTitle()

    %>

</div>


<div class="updated">

    Updated

    <%=

    r.getUpdatedAt() == null

    ? "recently"

    : r.getUpdatedAt()

    %>

    ·

    <%=

    r.getTemplate() == null

    ? "modern"

    : r.getTemplate()

    %>

</div>


<div class="actions">


<a
    class="primary"
    href="<%= contextPath %>/resume-builder?resumeId=<%= r.getResumeId() %>"
>
    Edit
</a>


<form
    method="post"
    action="<%= contextPath %>/my-resumes"
    onsubmit="return confirm('Delete this resume permanently?');"
>

    <input
        type="hidden"
        name="resumeId"
        value="<%= r.getResumeId() %>"
    >

    <input
        type="hidden"
        name="action"
        value="delete"
    >

    <button>
        Delete
    </button>

</form>


<form
    method="post"
    action="<%= contextPath %>/my-resumes"
>

    <input
        type="hidden"
        name="resumeId"
        value="<%= r.getResumeId() %>"
    >

    <input
        type="hidden"
        name="action"
        value="duplicate"
    >

    <button>
        Duplicate
    </button>

</form>


</div>


</div>

</div>


<% } %>


</div>


<% } %>


</main>


</div>


</body>

</html>