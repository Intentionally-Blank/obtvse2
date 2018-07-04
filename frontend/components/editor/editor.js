import "./editor.css";

document.addEventListener("DOMContentLoaded", () => {
  const slug = document.querySelector("#post_urls_attributes_0_slug");
  const title = document.querySelector("#post_revisions_attributes_0_title");
  const content = document.querySelector(
    "#post_revisions_attributes_0_content"
  );

  function slugify(content) {
    const request = new XMLHttpRequest();
    request.open("POST", "/api/functions/slugify", true);
    request.setRequestHeader(
      "Content-Type",
      "application/x-www-form-urlencoded"
    );
    request.onload = () => {
      if (request.status === 200) {
        slug.value = request.response;
      }
    };

    request.send(`content=${content}`);
  }

  function autoAdjust() {
    const outerHeight = parseInt(window.getComputedStyle(content).height, 10);
    const diff = outerHeight - content.clientHeight;

    // set the height to 0 in case of it has to be shrinked
    content.style.height = 0;

    // set the correct height
    // content.scrollHeight is the full height of the content, not just the visible part
    content.style.height = `${Math.max(50, content.scrollHeight + diff)}px`;
  }

  title.addEventListener("input", () => {
    slugify(title.value);
  });

  content.addEventListener("input", () => {
    autoAdjust();
  });

  window.addEventListener("resize", () => {
    autoAdjust();
  });
});
