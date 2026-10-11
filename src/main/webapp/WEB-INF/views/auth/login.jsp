<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Login | SmartResume</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/auth.css">

</head>

<body>

<div class="auth-page">

    <div class="auth-glow glow-one"></div>
    <div class="auth-glow glow-two"></div>


    <!-- LEFT -->

    <div class="auth-info">

        <a href="${pageContext.request.contextPath}/"
           class="auth-brand">

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
                WELCOME BACK
            </span>

            <h1>
                Your career.
                <span>Your resume.</span>
                Your future.
            </h1>

            <p>
                Continue building your professional profile
                and create resumes that get noticed.
            </p>


            <div class="info-points">

                <div>
                    <span>✓</span>
                    Access all your resumes
                </div>

                <div>
                    <span>✓</span>
                    Continue editing anytime
                </div>

                <div>
                    <span>✓</span>
                    Track your resume score
                </div>

                <div>
                    <span>✓</span>
                    Download professional PDFs
                </div>

            </div>

        </div>

    </div>


    <!-- LOGIN -->

    <div class="auth-form-wrapper">

        <div class="auth-card login-card">

            <div class="mobile-logo">

                <div class="brand-icon">S</div>

                <strong>SmartResume</strong>

            </div>


            <div class="form-header">

                <span class="form-badge">
                    ✦ WELCOME BACK
                </span>

                <h2>Welcome back</h2>

                <p>
                    Login to continue to your dashboard.
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


            <form action="${pageContext.request.contextPath}/login"
                  method="post">


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
                        placeholder="Enter your password"
                        required>

                </div>


                <div class="form-extra">

                    <label class="remember">

                        <input type="checkbox"
                               name="remember">

                        <span>Remember me</span>

                    </label>

                    <a href="#" onclick="return false;">
                        Forgot password?
                    </a>

                </div>


                <button type="submit" class="submit-btn">

                    Login to SmartResume

                    <span>→</span>

                </button>

            </form>


            <div class="auth-switch">

                Don't have an account?

                <a href="${pageContext.request.contextPath}/register">
                    Create Account
                </a>

            </div>


            <div class="back-home">

                <a href="${pageContext.request.contextPath}/">
                    ← Back to SmartResume
                </a>

            </div>

        </div>

    </div>

</div>

</body>
</html>