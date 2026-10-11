
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Settings | SmartResume</title>
<style>
*{box-sizing:border-box}body{margin:0;font-family:Arial,sans-serif;background:#f5f7fb;color:#172033}
.top{height:70px;background:#fff;border-bottom:1px solid #e5e9f2;display:flex;align-items:center;justify-content:space-between;padding:0 6%;gap:15px}
.brand{font-size:22px;font-weight:800;color:#3459db;text-decoration:none}.back{color:#3459db;text-decoration:none;font-weight:600}
main{max-width:760px;margin:45px auto;padding:0 20px}.heading{margin-bottom:25px}.heading h1{margin:0 0 8px;font-size:30px}.heading p{color:#697386;margin:0}
.card{background:#fff;border:1px solid #e5e9f2;border-radius:16px;padding:30px;box-shadow:0 8px 28px #1720330a}
.card h2{font-size:20px;margin:0 0 8px}.desc{color:#697386;font-size:14px;line-height:1.6;margin:0 0 22px}
label{display:block;font-weight:600;margin:18px 0 8px}input{width:100%;padding:13px 14px;border:1px solid #d8deea;border-radius:9px;font-size:15px;outline-color:#4565e8}
button{margin-top:22px;padding:13px 20px;border:0;border-radius:9px;background:#3459db;color:white;font-weight:700;cursor:pointer}
.message{padding:12px 14px;border-radius:8px;margin:15px 0;background:#e7f8ee;color:#17653b}.error{background:#fff0f0;color:#a32525}
.note{margin-top:18px;padding:14px;background:#f1f4ff;border-radius:9px;color:#455477;font-size:13px;line-height:1.6}
@media(max-width:520px){.card{padding:20px}.heading h1{font-size:25px}}
</style>
</head>
<body>
<header class="top">
<a class="brand" href="<%= contextPath %>/dashboard">SmartResume</a>
<a class="back" href="<%= contextPath %>/dashboard">← Dashboard</a>
</header>
<main>
<div class="heading"><h1>Settings</h1><p>Keep your account secure.</p></div>
<section class="card">
<h2>Change Password</h2>
<p class="desc">Enter your current password, then choose a new password for your account.</p>
<% if (request.getAttribute("success") != null) { %>
<div class="message"><%= request.getAttribute("success") %></div>
<% } %>
<% if (request.getAttribute("error") != null) { %>
<div class="message error"><%= request.getAttribute("error") %></div>
<% } %>
<form method="post" action="<%= contextPath %>/settings" autocomplete="off">
<label for="currentPassword">Current password</label>
<input id="currentPassword" name="currentPassword" type="password" autocomplete="current-password" required>
<label for="newPassword">New password</label>
<input id="newPassword" name="newPassword" type="password" minlength="8" maxlength="128" autocomplete="new-password" required>
<label for="confirmPassword">Confirm new password</label>
<input id="confirmPassword" name="confirmPassword" type="password" minlength="8" maxlength="128" autocomplete="new-password" required>
<button type="submit">Update Password</button>
</form>
<div class="note">Use at least 8 characters. Your current password is verified before any change is saved.</div>
</section>
</main>
</body>
</html>