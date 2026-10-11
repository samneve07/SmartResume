function toggleMenu() {

    const nav = document.querySelector(".nav-links");

    if (!nav) return;

    if (nav.style.display === "flex") {
        nav.style.display = "";
    } else {
        nav.style.display = "flex";
        nav.style.position = "absolute";
        nav.style.top = "78px";
        nav.style.left = "0";
        nav.style.width = "100%";
        nav.style.padding = "25px";
        nav.style.flexDirection = "column";
        nav.style.background = "rgba(7,7,11,.97)";
        nav.style.borderBottom = "1px solid #22222d";
    }
}


// Navbar active section

const sections = document.querySelectorAll("section[id]");
const navLinks = document.querySelectorAll(".nav-links a");

window.addEventListener("scroll", () => {

    let current = "";

    sections.forEach(section => {

        const sectionTop = section.offsetTop - 150;

        if (window.scrollY >= sectionTop) {
            current = section.getAttribute("id");
        }

    });

    navLinks.forEach(link => {

        link.classList.remove("active");

        if (link.getAttribute("href") === "#" + current) {
            link.classList.add("active");
        }

    });

});