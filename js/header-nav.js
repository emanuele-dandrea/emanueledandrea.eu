const header = document.querySelector(".header");
const toggle = document.querySelector(".menu-toggle");

toggle.addEventListener("click", () => {
  header.classList.toggle("menu-open");
});
