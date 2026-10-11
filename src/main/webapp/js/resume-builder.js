document.addEventListener("DOMContentLoaded", function () {

    const root =
        document.getElementById("resumePreview");

    if (!root) {
        return;
    }


    const fields = {

        fullName:
            document.getElementById("fullName"),

        email:
            document.getElementById("email"),

        phone:
            document.getElementById("phone"),

        location:
            document.getElementById("location"),

        linkedin:
            document.getElementById("linkedin"),

        github:
            document.getElementById("github"),

        summary:
            document.getElementById("summary"),

        experience:
            document.getElementById("experience"),

        projects:
            document.getElementById("projects"),

        education:
            document.getElementById("education"),

        certifications:
            document.getElementById("certifications"),

        languages:
            document.getElementById("languages"),

        skills:
            document.getElementById("skills")

    };


    const preview = {

        name:
            document.getElementById("previewName"),

        initials:
            document.getElementById("previewInitials"),

        email:
            document.getElementById("previewEmail"),

        phone:
            document.getElementById("previewPhone"),

        location:
            document.getElementById("previewLocation"),

        linkedin:
            document.getElementById("previewLinkedin"),

        github:
            document.getElementById("previewGithub"),

        summary:
            document.getElementById("previewSummary"),

        experience:
            document.getElementById("previewExperience"),

        projects:
            document.getElementById("previewProjects"),

        education:
            document.getElementById("previewEducation"),

        certifications:
            document.getElementById("previewCertifications"),

        languages:
            document.getElementById("previewLanguages"),

        skills:
            document.getElementById("previewSkills")

    };


    function text(value, fallback) {

        if (!value || value.trim() === "") {
            return fallback;
        }

        return value.trim();
    }


    function updatePreview() {

        const name =
            text(fields.fullName.value, "Your Name");


        preview.name.textContent =
            name;


        if (preview.initials) {

            const parts =
                name.split(/\s+/).filter(Boolean);

            let initials = "SN";

            if (parts.length === 1) {

                initials =
                    parts[0]
                        .substring(0, 2)
                        .toUpperCase();

            } else if (parts.length > 1) {

                initials =
                    (
                        parts[0][0] +
                        parts[parts.length - 1][0]
                    ).toUpperCase();
            }

            preview.initials.textContent =
                initials;
        }


        preview.email.textContent =
            text(fields.email.value, "your@email.com");


        preview.phone.textContent =
            text(fields.phone.value, "+91 00000 00000");


        preview.location.textContent =
            text(fields.location.value, "Mumbai, India");


        preview.linkedin.textContent =
            text(fields.linkedin.value, "linkedin.com/in/you");


        preview.github.textContent =
            text(fields.github.value, "github.com/you");


        preview.summary.textContent =
            text(
                fields.summary.value,
                "Write a concise professional summary that explains what you do, what you are good at and the kind of opportunity you are looking for."
            );


        preview.experience.textContent =
            text(
                fields.experience.value,
                "Your professional experience will appear here."
            );


        preview.projects.textContent =
            text(
                fields.projects.value,
                "Your projects will appear here."
            );


        preview.education.textContent =
            text(
                fields.education.value,
                "Your academic background will appear here."
            );


        preview.certifications.textContent =
            text(
                fields.certifications.value,
                "Your certifications will appear here."
            );


        preview.languages.textContent =
            text(
                fields.languages.value,
                "English · Hindi · Marathi"
            );


        updateSkills();

        updateCounters();

        setSaveStatus("Unsaved changes");
    }


    function updateSkills() {

        const raw =
            fields.skills.value.trim();


        preview.skills.innerHTML = "";


        if (!raw) {

            [
                "Java",
                "SQL",
                "Web Development"
            ].forEach(function (skill) {

                const span =
                    document.createElement("span");

                span.textContent =
                    skill;

                preview.skills.appendChild(span);
            });

            return;
        }


        const skills =
            raw
                .split(/[,|\n]/)
                .map(function (item) {
                    return item.trim();
                })
                .filter(Boolean)
                .slice(0, 12);


        skills.forEach(function (skill) {

            const span =
                document.createElement("span");

            span.textContent =
                skill;

            preview.skills.appendChild(span);

        });
    }


    function updateCounters() {

        const summaryCount =
            document.getElementById("summaryCount");

        const experienceCount =
            document.getElementById("experienceCount");


        if (summaryCount) {

            summaryCount.textContent =
                fields.summary.value.length +
                " / 900";
        }


        if (experienceCount) {

            experienceCount.textContent =
                fields.experience.value.length +
                " characters";
        }
    }


    Object.values(fields).forEach(function (field) {

        if (!field) {
            return;
        }

        field.addEventListener(
            "input",
            updatePreview
        );

    });


    /*
     * TEMPLATE SWITCHING
     */

    const templateInputs =
        document.querySelectorAll(
            'input[name="template"]'
        );


    templateInputs.forEach(function (input) {

        input.addEventListener(
            "change",
            function () {

                const template =
                    input.value;

                root.className =
                    "resume-paper template-" +
                    template +
                    " density-" +
                    getDensity();

                setSaveStatus(
                    "Template changed"
                );
            }
        );

    });


    /*
     * COLOR SWITCHING
     */

    const colorInputs =
        document.querySelectorAll(
            'input[name="themeColor"]'
        );


    colorInputs.forEach(function (input) {

        input.addEventListener(
            "change",
            function () {

                root.style
                    .setProperty(
                        "--accent",
                        input.value
                    );

                setSaveStatus(
                    "Accent updated"
                );
            }
        );

    });


    /*
     * DENSITY
     */

    const densityControl =
        document.getElementById(
            "densityControl"
        );


    if (densityControl) {

        densityControl.addEventListener(
            "change",
            function () {

                updateDensity();

                setSaveStatus(
                    "Spacing updated"
                );
            }
        );
    }


    function getDensity() {

        if (!densityControl) {
            return "normal";
        }

        return densityControl.value;
    }


    function updateDensity() {

        const currentTemplate =
            getSelectedTemplate();

        root.className =
            "resume-paper template-" +
            currentTemplate +
            " density-" +
            getDensity();
    }


    function getSelectedTemplate() {

        const selected =
            document.querySelector(
                'input[name="template"]:checked'
            );

        return selected
            ? selected.value
            : "modern";
    }


    /*
     * PREVIEW SCALE
     */

    const scaleControl =
        document.getElementById(
            "scaleControl"
        );


    if (scaleControl) {

        scaleControl.addEventListener(
            "input",
            function () {

                const value =
                    Number(scaleControl.value);

                root.style.transform =
                    "scale(" +
                    value / 100 +
                    ")";

                const label =
                    document.getElementById(
                        "zoomLabel"
                    );

                if (label) {
                    label.textContent =
                        value + "%";
                }
            }
        );
    }


    /*
     * SAVE STATUS
     */

    function setSaveStatus(message) {

        const status =
            document.getElementById(
                "saveStatus"
            );

        if (status) {
            status.textContent =
                message;
        }
    }


    /*
     * FORM SUBMIT
     */

    const form =
        document.getElementById(
            "resumeForm"
        );


    if (form) {

        form.addEventListener(
            "submit",
            function () {

                setSaveStatus(
                    "Saving..."
                );

            }
        );
    }


    updatePreview();

});


/*
 * ZOOM BUTTONS
 */

let currentZoom = 85;


function changeZoom(amount) {

    currentZoom += amount;


    if (currentZoom < 60) {
        currentZoom = 60;
    }


    if (currentZoom > 110) {
        currentZoom = 110;
    }


    const preview =
        document.getElementById(
            "resumePreview"
        );


    if (preview) {

        preview.style.transform =
            "scale(" +
            currentZoom / 100 +
            ")";

    }


    const label =
        document.getElementById(
            "zoomLabel"
        );


    if (label) {
        label.textContent =
            currentZoom + "%";
    }
}


/*
 * PREVIEW MODE
 */

function togglePreviewMode() {

    document.body.classList.toggle(
        "preview-only"
    );


    const editor =
        document.querySelector(
            ".editor"
        );


    const preview =
        document.querySelector(
            ".preview-area"
        );


    if (!editor || !preview) {
        return;
    }


    if (
        document.body.classList.contains(
            "preview-only"
        )
    ) {

        editor.style.display =
            "none";

        preview.style.width =
            "100%";

    } else {

        editor.style.display =
            "";

        preview.style.width =
            "";

    }
}