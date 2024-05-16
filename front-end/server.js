const http = require("http");
const fs = require("fs");
const path = require("path");

const hostname = "127.0.0.1";
const port = 3000;

const server = http.createServer((req, res) => {
  // Set the content type based on the file extension
  const contentType = {
    ".html": "text/html",
    ".css": "text/css",
    ".js": "text/javascript",
    ".png": "image/png",
    ".jpg": "image/jpeg",
    ".gif": "image/gif",
  };

  // Get the file path from the URL
  let filePath = "." + req.url;
  if (filePath === "./") {
    filePath = "./front-end/index.html"; // Serve index.html if root URL is requested
  }

  // Get the file extension
  const extname = path.extname(filePath);

  // Determine the content type
  const contentTypeHeader = contentType[extname] || "application/octet-stream";

  // Read the file
  fs.readFile(filePath, (err, content) => {
    if (err) {
      // If the file is not found, return a 404 error
      if (err.code === "ENOENT") {
        res.writeHead(404, { "Content-Type": "text/html" });
        res.end("404 Not Found");
      } else {
        // For other errors, return a 500 error
        res.writeHead(500);
        res.end(`Server Error: ${err.code}`);
      }
    } else {
      // If the file is found, serve it with the appropriate content type
      res.writeHead(200, { "Content-Type": contentTypeHeader });
      res.end(content, "utf-8");
    }
  });
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
