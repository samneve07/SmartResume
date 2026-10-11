
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.smartresume.dao.UserDAO.UserData" %>
<%
    String contextPath = request.getContextPath();
    UserData user = (UserData) request.getAttribute("profileUser");
    String fullName = user != null ? user.getFullName() : "";
    String email = user != null ? user.getEmail() : "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>My Profile | SmartResume</title>
<style>
*{box-sizing:border-box}body{margin:0;font-family:Arial,sans-serif;background:#f5f7fb;color:#172033}
.top{height:70px;background:#fff;border-bottom:1px solid #e5e9f2;display:flex;align-items:center;justify-content:space-between;padding:0 6%;gap:15px}
.brand{font-size:22px;font-weight:800;color:#3459db;text-decoration:none}.back{color:#3459db;text-decoration:none;font-weight:600}
main{max-width:760px;margin:45px auto;padding:0 20px}.heading{margin-bottom:25px}.heading h1{margin:0 0 8px;font-size:30px}.heading p{color:#697386;margin:0}
.card{background:#fff;border:1px solid #e5e9f2;border-radius:16px;padding:30px;box-shadow:0 8px 28px #1720330a}
.avatar{width:66px;height:66px;border-radius:18px;background:#e9edff;color:#3459db;display:grid;place-items:center;font-size:25px;font-weight:bold;margin-bottom:20px}
label{display:block;font-weight:600;margin:18px 0 8px}input{width:100%;padding:13px 14px;border:1px solid #d8deea;border-radius:9px;font-size:15px;outline-color:#4565e8}
button{margin-top:22px;padding:13px 20px;border:0;border-radius:9px;background:#3459db;color:white;font-weight:700;cursor:pointer}
.message{padding:12px 14px;border-radius:8px;margin:15px 0;background:#e7f8ee;color:#17653b}.error{background:#fff0f0;color:#a32525}
@media(max-width:520px){.card{padding:20px}.heading h1{font-size:25px}}
</style>
</head>
<body>
<header class="top">
<a class="brand" href="<%= contextPath %>/dashboard">SmartResume</a>
<a class="back" href="<%= contextPath %>/dashboard">← Dashboard</a>
</header>
<main>
<div class="heading"><h1>My Profile</h1><p>Manage your personal account information.</p></div>
<section class="card">
<div class="avatar"><%= fullName.isEmpty() ? "U" : fullName.substring(0,1).toUpperCase() %></div>
<% if ("1".equals(request.getParameter("updated"))) { %>
<div class="message">Profile updated successfully.</div>
<% } %>
<% if (request.getAttribute("error") != null) { %>
<div class="message error"><%= request.getAttribute("error") %></div>
<% } %>
<form method="post" action="<%= contextPath %>/profile">
<label for="fullName">Full name</label>
<input id="fullName" name="fullName" maxlength="100" required value="<%= fullName.replace("&","&amp;").replace("\"","&quot;").replace("<","&lt;").replace(">","&gt;") %>">
<label for="email">Email address</label>
<input id="email" name="email" type="email" maxlength="254" required value="<%= email.replace("&","&amp;").replace("\"","&quot;").replace("<","&lt;").replace(">","&gt;") %>">
<button type="submit">Save Changes</button>
</form>
</section>
</main>
</body>
</html>