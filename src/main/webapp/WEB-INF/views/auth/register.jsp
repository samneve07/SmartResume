<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Create Account | SmartResume</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/auth.css">

</head>

<body>

<div class="auth-page">

    <div class="auth-glow glow-one"></div>
    <div class="auth-glow glow-two"></div>

    <!-- LEFT SIDE -->

    <div class="auth-info">

        <a href="${pageContext.request.contextPath}/" class="auth-brand">

            <div class="brand-icon">
                S
            </div>

            <div>
                <strong>SmartResume</strong>
                <span>Build. Stand Out. Get Hired.</span>
            </div>

        </a>


        <div class="info-content">

            <span class="eyebrow">
                START YOUR CAREER JOURNEY
            </span>

            <h1>
                Your next
                <span>opportunity</span>
                starts here.
            </h1>

            <p>
                Create a professional resume, optimize it for ATS
                systems and make your profile recruiter-ready.
            </p>


            <div class="info-points">

                <div>
                    <span>✓</span>
                    Professional resume templates
                </div>

                <div>
                    <span>✓</span>
                    ATS resume analysis
                </div>

                <div>
                    <span>✓</span>
                    Live resume preview
                </div>

                <div>
                    <span>✓</span>
                    Download & share your resume
                </div>

            </div>

        </div>

    </div>


    <!-- FORM -->

    <div class="auth-form-wrapper">

        <div class="auth-card">

            <div class="mobile-logo">

                <div class="brand-icon">S</div>

                <strong>SmartResume</strong>

            </div>


            <div class="form-header">

                <span class="form-badge">
                    ✦ FREE ACCOUNT
                </span>

                <h2>Create your account</h2>

                <p>
                    Start building your professional resume today.
                </p>

            </div>


            <% if (request.getAttribute("error") != null) { %>

                <div class="alert error">
                    <span>!</span>
                    <%= request.getAttribute("error") %>
                </div>

            <% } %>


            <% if (request.getAttribute("success") != null) { %>

                <div class="alert success">
                    <span>✓</span>
                    <%= request.getAttribute("success") %>
                </div>

            <% } %>


            <form action="${pageContext.request.contextPath}/register"
                  method="post"
                  autocomplete="off">


                <div class="input-group">

                    <label>Full Name</label>

                    <input
                        type="text"
                        name="fullName"
                        placeholder="Enter your full name"
                        required>

                </div>


                <div class="input-group">

                    <label>Email</label>

                    <input
                        type="email"
                        name="email"
                        placeholder="Enter your email"
                        required>

                </div>


                <div class="input-group">

                    <label>Password</label>

                    <input
                        type="password"
                        name="password"
                        placeholder="Minimum 8 characters"
                        minlength="8"
                        required>

                </div>


                <div class="input-group">

                    <label>Confirm Password</label>

                    <input
                        type="password"
                        name="confirmPassword"
                        placeholder="Re-enter your password"
                        minlength="8"
                        required>

                </div>


                <button type="submit" class="submit-btn">

                    Create Account

                    <span>→</span>

                </button>

            </form>


            <div class="auth-switch">

                Already have an account?

                <a href="${pageContext.request.contextPath}/login">
                    Login
                </a>

            </div>


            <div class="terms">

                By creating an account, you agree to our
                Terms of Service and Privacy Policy.

            </div>

        </div>

    </div>

</div>

</body>
</html>