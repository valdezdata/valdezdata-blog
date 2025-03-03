document.addEventListener("DOMContentLoaded", function () {
  const backToTopButton = document.getElementById("back-to-top");

  // Don't show the button on very short pages
  if (document.body.scrollHeight <= window.innerHeight + 300) {
    backToTopButton.style.display = "none";
    return;
  }

  // Show button only when user scrolls down 300px
  window.addEventListener("scroll", function () {
    if (window.pageYOffset > 300) {
      backToTopButton.classList.add("show");
    } else {
      backToTopButton.classList.remove("show");
    }
  });

  // Initial check - don't show on page load
  backToTopButton.classList.remove("show");

  // Scroll to top when button is clicked
  backToTopButton.addEventListener("click", function () {
    // Add a terminal-like command output
    const commandOutput = document.createElement("div");
    commandOutput.classList.add("command-output");
    commandOutput.innerHTML = '<span class="prompt">$</span> cd ~';

    // Only append to content if it exists
    const contentDiv = document.querySelector(".content");
    if (contentDiv) {
      contentDiv.appendChild(commandOutput);
    }

    // Scroll to top with animation
    window.scrollTo({
      top: 0,
      behavior: "smooth",
    });
  });
});
