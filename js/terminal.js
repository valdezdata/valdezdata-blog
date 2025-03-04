document.addEventListener("DOMContentLoaded", () => {
  // Get the typing text element and container for tags
  const typingText = document.getElementById("typing-text");
  const tagsContainer = document.getElementById("tags-container");

  // Hide tags container initially
  if (tagsContainer) {
    tagsContainer.style.display = "none";
  }

  // Define the texts to type
  const tagline = "Desbloqueando el Potencial de los Datos";
  const tags =
    "#dataengineering #datainfra #mlops #dataintegrity #ai #dataops #security";

  // Define colors (match your CSS variables)
  const taglineColor = "var(--prompt-color)"; // Green color
  const tagsColor = "var(--highlight-color)"; // Orange color

  // Variables for tracking typing state
  let isTypingTagline = true;
  let isErasing = false;
  let i = 0;
  const typingSpeed = 60; // Regular typing speed
  const erasingSpeed = 50; // Faster erasing speed
  const pauseBeforeErase = 1500; // Pause before erasing
  const pauseBeforeTags = 500; // Pause before typing tags

  // Set initial color
  typingText.style.color = taglineColor;

  function typeWriter() {
    // Typing the tagline
    if (isTypingTagline && !isErasing) {
      if (i < tagline.length) {
        typingText.innerHTML += tagline.charAt(i);
        i++;
        setTimeout(typeWriter, typingSpeed);
      } else {
        // Tagline complete, pause before erasing
        setTimeout(() => {
          isErasing = true;
          typeWriter();
        }, pauseBeforeErase);
      }
    }
    // Erasing the tagline
    else if (isTypingTagline && isErasing) {
      if (i > 0) {
        typingText.innerHTML = tagline.substring(0, i - 1);
        i--;
        setTimeout(typeWriter, erasingSpeed);
      } else {
        // Erased completely, switch to tags
        isTypingTagline = false;
        isErasing = false;
        i = 0;
        // Change color for hashtags
        typingText.style.color = tagsColor;
        setTimeout(typeWriter, pauseBeforeTags);
      }
    }
    // Typing the tags
    else if (!isTypingTagline && !isErasing) {
      if (i < tags.length) {
        typingText.innerHTML += tags.charAt(i);
        i++;
        setTimeout(typeWriter, typingSpeed);
      }
      // Typing complete, stop
    }
  }

  // Start the typing animation
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
