// Get app version from package.json
fetch("package.json")
  .then((response) => response.json())
  .then((data) => {
    // Extract version from package.json
    const version = data.version;
    // Update the HTML element with the version
    document.getElementById("version").textContent = `v${version}`;
  })
  .catch((error) => console.error("Error fetching package.json:", error));