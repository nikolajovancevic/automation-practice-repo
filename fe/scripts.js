// Hamburger menu 
const hamburger = document.querySelector('.hamburger');

if (hamburger) {
  // Add a click event listener
  hamburger.addEventListener('click', () => {
    console.log('Hamburger clicked!'); // Debugging log
    hamburger.classList.toggle('is-active'); // Toggle class
  });
} else {
  console.error('Hamburger button not found!');
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