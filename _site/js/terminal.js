document.addEventListener("DOMContentLoaded", () => {
  // Clear and hide tags initially
  const tagsContainer = document.getElementById("tags-container");
  if (tagsContainer) {
    tagsContainer.innerHTML = "";
    tagsContainer.style.display = "flex";
  }

  // Array of hashtags
  const tags = [
    "#dataengineering",
    "#datainfra",
    "#mlops",
    "#dataintegrity",
    "#ai",
    "#dataops",
    "#security",
  ];

  // Typing effect for the tagline
  const typingText = document.getElementById("typing-text");
  const text = "Desbloqueando el Potencial de los Datos";
  let i = 0;
  const typingSpeed = 50; // milliseconds per character

  function typeWriter() {
    if (i < text.length) {
      typingText.innerHTML += text.charAt(i);
      i++;
      setTimeout(typeWriter, typingSpeed);
    } else {
      // After tagline is typed, start typing hashtags
      setTimeout(typeHashtags, 500);
    }
  }

  // Function to type hashtags one by one
  let tagIndex = 0;
  let charIndex = 0;

  function typeHashtags() {
    if (tagIndex < tags.length) {
      if (charIndex === 0) {
        // Create a new span for this tag
        const tagSpan = document.createElement("span");
        tagSpan.className = "tag";
        tagSpan.id = `tag-${tagIndex}`;
        tagsContainer.appendChild(tagSpan);
      }

      const currentTag = tags[tagIndex];
      const tagSpan = document.getElementById(`tag-${tagIndex}`);

      if (charIndex < currentTag.length) {
        // Type the next character of the current tag
        tagSpan.textContent += currentTag.charAt(charIndex);
        charIndex++;
        setTimeout(typeHashtags, 50);
      } else {
        // Move to the next tag
        tagsContainer.appendChild(document.createTextNode(" "));
        tagIndex++;
        charIndex = 0;
        setTimeout(typeHashtags, 200);
      }
    }
  }

  // Start the typing animation after a short delay
  setTimeout(typeWriter, 1000);

  // Simulate terminal behavior with links
  const terminalLinks = document.querySelectorAll(
    ".terminal-nav a, .post-title a, .read-more, .pagination a",
  );

  terminalLinks.forEach((link) => {
    link.addEventListener("click", function (e) {
      // Only process if it's an internal link
      if (this.hostname === window.location.hostname) {
        e.preventDefault();
        const href = this.getAttribute("href");

        // Add a command-like output before navigating
        const commandOutput = document.createElement("div");
        commandOutput.classList.add("command-output");
        commandOutput.innerHTML = `<span class="prompt">$</span> cd ${href}`;
        document.querySelector(".content").appendChild(commandOutput);

        // Navigate after a short delay
        setTimeout(() => {
          window.location.href = href;
        }, 500);
      }
    });
  });
});
