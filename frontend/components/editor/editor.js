import "./editor.css";

document.addEventListener("DOMContentLoaded", () => {
  const slug = document.querySelector("#post_urls_attributes_0_slug");
  const title = document.querySelector("#post_revisions_attributes_0_title");
  const content = document.querySelector(
    "#post_revisions_attributes_0_content"
  );
  const previewSpace = document.querySelector("#preview-space");

  function slugify() {
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

    request.send(`content=${title.value}`);
  }

  function preview() {
    const request = new XMLHttpRequest();
    request.open("POST", "/api/functions/markdown_preview", true);
    request.setRequestHeader(
      "Content-Type",
      "application/x-www-form-urlencoded"
    );
    request.onload = () => {
      if (request.status === 200) {
        previewSpace.innerHTML = request.response;
        previewSpace.style.position = "absolute";
        previewSpace.style.left = `${content.offsetLeft}px`;
        previewSpace.style.top = `${content.offsetTop}px`;
        previewSpace.style.width = `${content.offsetWidth}px`;
        // previewSpace.style.height = `${content.offsetHeight}px`;
      }
    };

    request.send(`content=${content.value}`);
  }

  function autoAdjust() {
    const outerHeight = parseInt(window.getComputedStyle(content).height, 10);
    const diff = outerHeight - content.clientHeight;

    // set the height to 0 in case of it has to be shrinked
    content.style.height = 0;

    // set the correct height
    content.style.height = `${Math.max(50, content.scrollHeight + diff)}px`;
  }

  title.addEventListener("input", () => {
    slugify();
  });

  content.addEventListener("input", () => {
    autoAdjust();
  });

  window.addEventListener("resize", () => {
    autoAdjust();
  });

  document.querySelector("#preview-button").addEventListener("click", event => {
    event.preventDefault();
    preview();
  });

  previewSpace.addEventListener("click", () => {
    previewSpace.innerHTML = "";
  });
});
