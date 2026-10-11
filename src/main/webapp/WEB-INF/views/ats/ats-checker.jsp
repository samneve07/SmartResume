<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>

<%@ page import="com.smartresume.dao.ResumeDAO.ResumeData" %>

<%!

    public String esc(String value) {

        if (value == null) return "";

        return value.replace("&", "&amp;")

                    .replace("<", "&lt;")

                    .replace(">", "&gt;")

                    .replace("\"", "&quot;")

                    .replace("'", "&#39;");

    }

%>

<%

    String ctx = request.getContextPath();

    List<ResumeData> resumes =

        (List<ResumeData>) request.getAttribute("resumes");

    String selectedId =

        (String) request.getAttribute("selectedResumeId");

    String jobDescription =

        (String) request.getAttribute("jobDescription");

    String errorMessage =

        (String) request.getAttribute("errorMessage");

    String sourceName =

        (String) request.getAttribute("sourceName");

    Integer score = (Integer) request.getAttribute("score");

    List<String> matched =

        (List<String>) request.getAttribute("matchedKeywords");

    List<String> missing =

        (List<String>) request.getAttribute("missingKeywords");

    List<String> tips =

        (List<String>) request.getAttribute("tips");

    List<String> careerRoles =

        (List<String>) request.getAttribute("careerRoles");

    boolean analyzed =

        Boolean.TRUE.equals(request.getAttribute("analyzed"));

%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>ATS Career Analyzer | SmartResume</title>

<style>

* { box-sizing: border-box; }

:root {

    --brand: #6264e8;

    --ink: #172033;

    --muted: #697386;

    --line: #e5e8f0;

    --bg: #f5f6fb;

}

body {

    margin: 0;

    font-family: "Segoe UI", Arial, sans-serif;

    color: var(--ink);

    background: var(--bg);

}

.topbar {

    height: 70px;

    background: white;

    border-bottom: 1px solid var(--line);

    display: flex;

    align-items: center;

    justify-content: space-between;

    padding: 0 5%;

}

.brand {

    font-size: 21px;

    font-weight: 850;

    text-decoration: none;

    color: var(--ink);

}

.brand span { color: var(--brand); }

.back {

    color: var(--muted);

    text-decoration: none;

    font-weight: 650;

    font-size: 14px;

}

.container {

    max-width: 1250px;

    margin: 35px auto;

    padding: 0 22px 50px;

}

.eyebrow {

    color: var(--brand);

    font-size: 12px;

    font-weight: 850;

    letter-spacing: 2px;

    text-transform: uppercase;

}

h1 {

    font-size: clamp(29px, 4vw, 40px);

    margin: 10px 0;

    letter-spacing: -1px;

}

.subtitle {

    color: var(--muted);

    line-height: 1.7;

    margin: 0 0 25px;

}

.layout {

    display: grid;

    grid-template-columns: minmax(0, 1fr) minmax(0, 1fr);

    gap: 22px;

    align-items: start;

}

.card {

    min-width: 0;

    background: white;

    border: 1px solid var(--line);

    border-radius: 17px;

    padding: 24px;

    box-shadow: 0 8px 25px #17203308;

}

label {

    display: block;

    font-size: 14px;

    font-weight: 750;

    margin-bottom: 9px;

}

select, textarea, input[type="file"] {

    display: block;

    width: 100%;

    border: 1px solid #d9deea;

    border-radius: 10px;

    padding: 13px;

    background: white;

    color: var(--ink);

    font: inherit;

}

textarea {

    min-height: 230px;

    resize: vertical;

    line-height: 1.6;

}

.field { margin-bottom: 22px; }

.hint {

    color: var(--muted);

    font-size: 12px;

    line-height: 1.6;

    margin-top: 8px;

}

.or {

    display: flex;

    align-items: center;

    gap: 12px;

    color: #8a91a1;

    font-size: 12px;

    font-weight: 750;

    margin: 19px 0;

}

.or::before, .or::after {

    content: "";

    height: 1px;

    background: var(--line);

    flex: 1;

}

.btn {

    display: block;

    width: 100%;

    border: 0;

    border-radius: 11px;

    padding: 15px;

    background: var(--brand);

    color: white;

    font-size: 15px;

    font-weight: 800;

    cursor: pointer;

}

.btn:hover { filter: brightness(.96); }

.notice, .error {

    padding: 13px;

    border-radius: 10px;

    margin-top: 17px;

    font-size: 13px;

    line-height: 1.6;

}

.notice {

    color: #4547a8;

    background: #f0f1ff;

    border: 1px solid #e3e4ff;

}

.error {

    margin: 0 0 18px;

    color: #a42e25;

    background: #fff0ee;

    border: 1px solid #ffd5d0;

}

.result-head {

    display: flex;

    align-items: center;

    gap: 18px;

    margin: 22px 0;

}

.score {

    width: 105px;

    height: 105px;

    flex-shrink: 0;

    border: 8px solid #e8e9ff;

    border-radius: 50%;

    display: flex;

    justify-content: center;

    align-items: center;

    color: var(--brand);

    font-size: 27px;

    font-weight: 900;

}

.score small { font-size: 12px; }

.result-title {

    font-size: 20px;

    font-weight: 850;

    margin-bottom: 7px;

}

.muted {

    color: var(--muted);

    font-size: 13px;

    line-height: 1.6;

}

.section-title {

    font-size: 15px;

    font-weight: 850;

    margin: 24px 0 12px;

}

.chips {

    display: flex;

    flex-wrap: wrap;

    gap: 8px;

}

.chip {

    padding: 7px 11px;

    border-radius: 20px;

    font-size: 12px;

    overflow-wrap: anywhere;

}

.match { color: #167647; background: #e7f8ee; }

.missing { color: #ad392e; background: #fff0ed; }

.tip {

    padding: 11px 0;

    border-bottom: 1px solid #eceef3;

    font-size: 13px;

    line-height: 1.6;

}

.role {

    border: 1px solid var(--line);

    background: #fafaff;

    padding: 13px;

    border-radius: 11px;

    margin-bottom: 9px;

    font-size: 13px;

    line-height: 1.6;

    overflow-wrap: anywhere;

}

.role strong {

    display: block;

    color: var(--brand);

    margin-bottom: 3px;

}

.empty {

    padding: 25px 0;

}

@media (max-width: 800px) {

    .layout { grid-template-columns: 1fr; }

    .card { padding: 19px; }

    .container { margin-top: 24px; }

    .topbar { padding: 0 18px; }

}

/* ATS report dashboard styling. Upload form and existing page styles stay unchanged. */

.ats-report {

    padding: 25px;

}

.ats-gauge-wrap {

    display: flex;

    flex-direction: column;

    align-items: center;

    padding: 15px 0 27px;

}

.ats-gauge {
    width: 190px;
    height: 190px;
    border-radius: 50%;
    display: grid;
    place-items: center;
    background: conic-gradient(#f05a0a 0%, #e3e8f0 0%);
    position: relative;
    flex-shrink: 0;
}


.ats-gauge-inner {

    width: 166px;

    height: 166px;

    border-radius: 50%;

    background: #fff;

    display: flex;

    flex-direction: column;

    align-items: center;

    justify-content: center;

    gap: 5px;

}

.ats-gauge-inner strong {

    font-size: 49px;

    line-height: 1;

    letter-spacing: -2px;

}

.ats-gauge-inner span {

    color: #64748b;

    font-size: 13px;

    font-weight: 800;

    letter-spacing: 1px;

}

.ats-gauge-inner small {

    margin-top: 5px;

    border-radius: 20px;

    padding: 7px 14px;

    background: #fff5e9;

    color: #e65308;

    font-size: 11px;

    font-weight: 850;

}

.ats-gauge.strong .ats-gauge-inner small {

    color: #138348;

    background: #e8f8ee;

}

.ats-gauge.moderate .ats-gauge-inner small {

    color: #a96b00;

    background: #fff5df;

}

.ats-gauge-note {

    text-align: center;

    margin: 12px 0 0;

}

.ats-metrics {

    display: grid;

    grid-template-columns: 1fr 1fr;

    gap: 13px;

}

.ats-metric {

    border: 1px solid var(--line);

    border-radius: 13px;

    padding: 15px;

    min-width: 0;

}

.ats-metric-head {

    display: flex;

    justify-content: space-between;

    align-items: center;

    gap: 8px;

    font-size: 14px;

    font-weight: 800;

}

.ats-metric-head strong {

    font-size: 22px;

    color: #159653;

}

.ats-metric small {

    display: block;

    color: var(--muted);

    margin-top: 7px;

    font-size: 11px;

    line-height: 1.5;

}

.ats-track {

    height: 8px;

    background: #edf1f6;

    border-radius: 20px;

    overflow: hidden;

    margin-top: 13px;

}

.ats-fill {

    height: 100%;

    border-radius: inherit;

    transition: width .3s ease;

}

.keywords-fill {

    background: #16b85a;

}

.coverage-fill {

    background: #f05a0a;

}

.ats-section {

    margin-top: 27px;

}

.ats-section h3 {

    font-size: 19px;

    margin: 0 0 13px;

}

.ats-section-heading {

    display: flex;

    align-items: flex-start;

    justify-content: space-between;

    gap: 10px;

    flex-wrap: wrap;

}

.ats-section-heading span {

    font-size: 12px;

    color: var(--muted);

}

.ats-subheading {

    font-size: 13px;

    margin: 19px 0 10px;

}

@media (max-width: 800px) {

    .ats-metrics {

        grid-template-columns: 1fr;

    }

    .ats-gauge {

        width: 170px;

        height: 170px;

    }

    .ats-gauge-inner {

        width: 148px;

        height: 148px;

    }

}

/* Smooth ATS score gauge animation */
.ats-gauge {
    --animated-score: 0;
    transition: background 0.1s linear;
    animation: atsGaugeFill 1.8s ease-out forwards;
}

@keyframes atsGaugeFill {
    from {
        --animated-score: 0;
    }
    to {
        --animated-score: var(--score);
    }
}

@property --animated-score {
    syntax: "<number>";
    inherits: false;
    initial-value: 0;
}

</style>

</head>

<body>

<header class="topbar">

    <a class="brand" href="<%= ctx %>/dashboard">

        Smart<span>Resume</span>

    </a>

    <a class="back" href="<%= ctx %>/dashboard">← Dashboard</a>

</header>

<main class="container">

    <div class="eyebrow">Smart tools / Career intelligence</div>

    <h1>ATS Resume & Career Analyzer</h1>

    <p class="subtitle">

        Upload your resume, compare it with a job description,

        discover missing keywords and explore career roles related to your skills.

    </p>

    <div class="layout">

        <section class="card">

            <% if (errorMessage != null) { %>

                <div class="error"><%= esc(errorMessage) %></div>

            <% } %>

            <form method="post"

                  action="<%= ctx %>/ats"

                  enctype="multipart/form-data">

                <div class="field">

                    <label for="resumeFile">Upload resume (PDF or DOCX)</label>

                    <input

                        type="file"

                        id="resumeFile"

                        name="resumeFile"

                        accept=".pdf,.docx,application/pdf,application/vnd.openxmlformats-officedocument.wordprocessingml.document">

                    <div class="hint">

                        Maximum 10 MB. Text-based PDFs and DOCX files are supported.

                        Scanned PDFs may require OCR and might not contain extractable text.

                    </div>

                </div>

                <div class="or">OR USE A SAVED RESUME</div>

                <div class="field">

                    <label for="resumeId">Choose your saved resume</label>

                    <select name="resumeId" id="resumeId">

                        <option value="">Select a saved resume</option>

                        <% if (resumes != null) {

                            for (ResumeData r : resumes) {

                                String id = String.valueOf(r.getResumeId());

                        %>

                        <option value="<%= esc(id) %>"

                            <%= id.equals(selectedId) ? "selected" : "" %>>

                            <%= esc(r.getResumeTitle() == null

                                || r.getResumeTitle().isBlank()

                                ? "Untitled resume"

                                : r.getResumeTitle()) %>

                        </option>

                        <% } } %>

                    </select>

                    <div class="hint">

                        Upload a file OR select a saved resume. An uploaded file takes priority.

                    </div>

                </div>

                <div class="field">

                    <label for="jobDescription">Job description</label>

                    <textarea

                        name="jobDescription"

                        id="jobDescription"

                        required

                        placeholder="Paste the full job description, including responsibilities and required skills..."><%= esc(jobDescription) %></textarea>

                    <div class="hint">

                        For a useful comparison, paste the complete job description,

                        not a single word or short sentence.

                    </div>

                </div>

                <button class="btn" type="submit">

                    Analyze Resume & Find Suitable Roles →

                </button>

                <div class="notice">

                    The score is a keyword-match estimate, not an actual employer ATS

                    result or a guarantee of selection. Career suggestions are based

                    on detected resume keywords and are not a hiring prediction.

                </div>

            </form>

        </section>

    <section class="card ats-report">

          <% if (analyzed && score != null) { %>

        <div class="eyebrow">Your analysis report</div>

        <% if (sourceName != null && !sourceName.isBlank()) { %>

            <p class="muted">

                Resume analyzed: <strong><%= esc(sourceName) %></strong>

            </p>

        <% } %>

        <%

            int matchedCount = matched == null ? 0 : matched.size();

            int missingCount = missing == null ? 0 : missing.size();

            int totalCount = matchedCount + missingCount;

            int keywordScore = Math.max(0, Math.min(100, score));

            String status = keywordScore >= 80 ? "STRONG MATCH"

                          : keywordScore >= 60 ? "MODERATE MATCH"

                          : "NEEDS WORK";

            String statusClass = keywordScore >= 80 ? "strong"

                               : keywordScore >= 60 ? "moderate" : "weak";

        %>

        <div class="ats-gauge-wrap">

            <div class="ats-gauge <%= statusClass %>"

                 style="--score:<%= keywordScore %>">

                <div class="ats-gauge-inner">

                    <strong><%= keywordScore %></strong>

                    <span>ATS SCORE</span>

                    <small><%= status %></small>

                </div>

            </div>

            <p class="muted ats-gauge-note">

                Job-description keyword compatibility estimate

            </p>

        </div>

        <div class="ats-metrics">

            <div class="ats-metric">

                <div class="ats-metric-head">

                    <span>⌕ &nbsp; Keywords</span>

                    <strong><%= keywordScore %></strong>

                </div>

                <small>100% of the current measurable score</small>

                <div class="ats-track">

                    <div class="ats-fill keywords-fill"

                         style="width:<%= keywordScore %>%"></div>

                </div>

            </div>

            <div class="ats-metric">

                <div class="ats-metric-head">

                    <span>✓ &nbsp; Keyword coverage</span>

                    <strong><%= totalCount == 0 ? 0 :

                        (int)Math.round(matchedCount * 100.0 / totalCount) %></strong>

                </div>

                <small><%= matchedCount %> matched of <%= totalCount %> extracted terms</small>

                <div class="ats-track">

                    <div class="ats-fill coverage-fill"

                         style="width:<%= totalCount == 0 ? 0 :

                            (int)Math.round(matchedCount * 100.0 / totalCount) %>%"></div>

                </div>

            </div>

        </div>

        <div class="ats-section">

            <div class="ats-section-heading">

                <h3>Keyword Analysis</h3>

                <span><%= matchedCount %> matched · <%= missingCount %> missing</span>

            </div>

            <h4 class="ats-subheading">Matched keywords</h4>

            <div class="chips">

                <% if (matched != null && !matched.isEmpty()) {

                    for (String word : matched) { %>

                        <span class="chip match"><%= esc(word) %></span>

                <%  }

                   } else { %>

                    <span class="muted">No matched keywords found.</span>

                <% } %>

            </div>

            <h4 class="ats-subheading">Missing keywords</h4>

            <div class="chips">

                <% if (missing != null && !missing.isEmpty()) {

                    for (String word : missing) { %>

                        <span class="chip missing"><%= esc(word) %></span>

                <%  }

                   } else { %>

                    <span class="muted">No missing keywords detected.</span>

                <% } %>

            </div>

        </div>

        <div class="ats-section">

            <h3>Career Recommendations</h3>

            <p class="muted">

                Roles suggested from detected resume skills. These are

                possibilities to explore, not a guarantee of job suitability.

            </p>

            <% if (careerRoles != null && !careerRoles.isEmpty()) {

                for (String role : careerRoles) { %>

                    <div class="role">

                        <strong><%= esc(role) %></strong>

                        <span class="muted">

                            Compare your experience and projects with the role's requirements.

                        </span>

                    </div>

            <%  }

               } %>

        </div>

        <div class="ats-section">

            <h3>Improvement Suggestions</h3>

            <% if (tips != null && !tips.isEmpty()) {

                for (String tip : tips) { %>

                    <div class="tip">↗ &nbsp;<%= esc(tip) %></div>

            <%  }

               } %>

        </div>

        <div class="notice">

            This score measures keyword compatibility only. Formatting,

            readability and employer-specific ATS rules are not independently

            scored in this report.

        </div>

    <% } else { %>

        <div class="eyebrow">Your report</div>

        <div class="empty">

            <h2 style="font-size:23px; margin-bottom:10px">

                Your analysis will appear here

            </h2>

            <p class="muted">

                Upload a PDF/DOCX or select a saved resume, paste a job

                description and start the analysis.

            </p>

        </div>

        <div class="notice">

            Your report will include a compatibility score, keyword analysis,

            career suggestions and improvement tips.

        </div>

        <% if (resumes == null || resumes.isEmpty()) { %>

            <p class="muted">

                No saved resumes found yet. You can upload a PDF or DOCX instead.

            </p>

        <% } %>

    <% } %>

</section>

    </div>

</main>


<script>
document.addEventListener("DOMContentLoaded", function () {
    const gauge = document.querySelector(".ats-gauge");

    if (!gauge) return;

    const finalScore = Number(
        getComputedStyle(gauge).getPropertyValue("--score").trim()
    );

    if (!Number.isFinite(finalScore)) return;

    gauge.style.animation = "none";
    gauge.style.setProperty("--animated-score", "0");

    const duration = 1600;
    const startTime = performance.now();

    function animateGauge(now) {
        const progress = Math.min((now - startTime) / duration, 1);
        const eased = 1 - Math.pow(1 - progress, 3);

        gauge.style.setProperty(
            "--animated-score",
            String(finalScore * eased)
        );

        if (progress < 1) {
            requestAnimationFrame(animateGauge);
        }
    }

    requestAnimationFrame(animateGauge);
});
</script>
<script>
(function () {
    function animateATSGauge() {
        const gauge = document.querySelector(".ats-gauge");
        if (!gauge) return;

        const score = parseFloat(
            gauge.style.getPropertyValue("--score") ||
            getComputedStyle(gauge).getPropertyValue("--score")
        );

        if (!Number.isFinite(score)) return;

        const target = Math.max(0, Math.min(100, score));
        const duration = 1800;
        const start = performance.now();

        gauge.style.background =
            "conic-gradient(#f05a0a 0%, #e3e8f0 0%)";

        function frame(now) {
            const progress = Math.min((now - start) / duration, 1);
            const eased = 1 - Math.pow(1 - progress, 3);
            const value = target * eased;

            gauge.style.background =
                "conic-gradient(#f05a0a " + value +
                "%, #e3e8f0 " + value + "%)";

            if (progress < 1) {
                requestAnimationFrame(frame);
            }
        }

        requestAnimationFrame(frame);
    }

    if (document.readyState === "loading") {
        document.addEventListener("DOMContentLoaded", animateATSGauge);
    } else {
        animateATSGauge();
    }
})();
</script>
</body>

</html>
