/**
 * @exports scripts used in front-end
 */

function showTextOnClick() {
  var button = document.getElementById("button");
  var button_text = document.getElementById("button-text");

  button.style.display = "none";
  button_text.style.display = "block";
}

// Fetch package.json file
fetch("package.json")
  .then((response) => response.json())
  .then((data) => {
    // Extract version from package.json
    const version = data.version;
    // Update the HTML element with the version
    document.getElementById("version").textContent = version;
  })
  .catch((error) => console.error("Error fetching package.json:", error));
