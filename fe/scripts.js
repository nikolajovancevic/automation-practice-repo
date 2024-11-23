// Hamburger menu
const hamburger = document.querySelector(".hamburger");

if (hamburger) {
  // Add a click event listener
  hamburger.addEventListener("click", () => {
    console.log("Hamburger clicked!"); // Debugging log
    hamburger.classList.toggle("is-active"); // Toggle class
  });
} else {
  console.error("Hamburger button not found!");
}

// Get app version from package.json
fetch("package.json")
  .then((response) => response.json())
  .then((data) => {
    // Extract version from package.json
    const version = data.version;
    // Update the HTML element with the version
    document.getElementById("version").textContent = version;
  })
  .catch((error) => console.error("Error fetching package.json:", error));

// Counter for break button

function breakCounter() {
  let counter = parseInt(sessionStorage.getItem("counter")) || 0;
  const breakButton = document.getElementById("break-button");
  const breakCounter = document.getElementById("break-counter");

  breakButton.addEventListener("click", function(e) {
    // Prevent immediate redirection
    e.preventDefault();

    counter++;
    breakCounter.textContent = counter;

    sessionStorage.setItem("counter", counter);

    // Add a class to trigger the button expansion animation
    this.classList.add('expanding');

    // Wait for 2 seconds (duration of the animation), then redirect
    setTimeout(() => {
      // Perform redirection after the animation
      window.location.href = this.href;
    }, 1000);
  });
}

breakCounter();
