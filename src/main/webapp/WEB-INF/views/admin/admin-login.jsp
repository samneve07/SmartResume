<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String contextPath =
            request.getContextPath();

    boolean error =
            "true".equals(
                    request.getParameter("error")
            );
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
    SmartResume — Admin
</title>


<style>

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}


body {

    min-height: 100vh;

    display: flex;

    align-items: center;

    justify-content: center;

    font-family:
        Inter,
        Segoe UI,
        Arial,
        sans-serif;

    background: #111;

    color: #fff;
}


.login-shell {

    width: 430px;

    max-width: calc(100% - 35px);

    background: #1a1a1a;

    border: 1px solid #292929;

    border-radius: 22px;

    padding: 38px;

    box-shadow:
        0 30px 80px
        rgba(0,0,0,.35);
}


.logo {

    width: 48px;
    height: 48px;

    border-radius: 13px;

    background: #c8ff32;

    color: #111;

    display: grid;

    place-items: center;

    font-size: 20px;

    font-weight: 950;

    margin-bottom: 25px;
}


.eyebrow {

    color: #c8ff32;

    font-size: 10px;

    font-weight: 900;

    letter-spacing: 1.8px;

    text-transform: uppercase;
}


h1 {

    font-size: 31px;

    letter-spacing: -1.5px;

    margin-top: 7px;
}


.subtitle {

    color: #888;

    font-size: 13px;

    line-height: 1.6;

    margin-top: 8px;

    margin-bottom: 27px;
}


.field {

    margin-bottom: 16px;
}


label {

    display: block;

    font-size: 10px;

    font-weight: 850;

    color: #aaa;

    margin-bottom: 7px;
}


input {

    width: 100%;

    padding: 13px 14px;

    border-radius: 10px;

    border: 1px solid #333;

    background: #111;

    color: #fff;

    outline: none;

    font-size: 13px;
}


input:focus {

    border-color: #c8ff32;
}


button {

    width: 100%;

    margin-top: 8px;

    padding: 13px;

    border: none;

    border-radius: 10px;

    background: #c8ff32;

    color: #111;

    font-weight: 950;

    cursor: pointer;
}


.error {

    background: rgba(255,70,70,.1);

    border: 1px solid rgba(255,70,70,.3);

    color: #ff8d8d;

    padding: 10px;

    border-radius: 9px;

    font-size: 11px;

    margin-bottom: 17px;
}


.back {

    display: block;

    text-align: center;

    margin-top: 20px;

    color: #777;

    text-decoration: none;

    font-size: 11px;
}

</style>

</head>


<body>


<div class="login-shell">


<div class="logo">
    S
</div>


<div class="eyebrow">
    SmartResume Admin
</div>


<h1>
    Welcome back.
</h1>


<p class="subtitle">
    Manage users, resumes, templates and
    platform analytics from one place.
</p>


<% if (error) { %>

<div class="error">
    Invalid administrator credentials.
</div>

<% } %>


<form
    method="post"
    action="<%= contextPath %>/admin"
>


<div class="field">

<label>
    ADMIN EMAIL
</label>

<input
    type="email"
    name="email"
    placeholder="admin@smartresume.com"
    required
>

</div>


<div class="field">

<label>
    PASSWORD
</label>

<input
    type="password"
    name="password"
    placeholder="Enter admin password"
    required
>

</div>


<button type="submit">
    Enter Admin Panel →
</button>


</form>


<a
    class="back"
    href="<%= contextPath %>/dashboard"
>
    ← Back to SmartResume
</a>


</div>


</body>

</html>