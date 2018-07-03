import "./auth-form.css";

document.addEventListener("DOMContentLoaded", () => {
  const idToken = window.location.hash
    .substr(1)
    .split("&")
    .map(x => x.split("="))
    .reduce((m, x) => (x[0] === "id_token" ? x[1] : m));

  if (idToken.length > 2) {
    document.querySelector("#jwt").value = idToken;
    document.querySelector(".auth-form form").submit();
  }
});
