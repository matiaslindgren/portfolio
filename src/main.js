function withoutChildren(e) {
  while (e.firstChild) {
    e.removeChild(e.firstChild);
  }
  return e;
}

// Render the DOM body with dom-to-image as a PNG and place it inside the DOM
// Repeat 'numPasses' times.
function renderSelf(numPasses) {
  if (numPasses <= 0) {
    return;
  }
  const imgContainer = document.getElementById('self-img-container');
  domtoimage.toPng(document.body)
    .then((dataUrl) => {
      const img = document.createElement("img");
      img.alt = "full, recursive rendering of this page as a PNG image, embedded into a scrollable view";
      img.src = dataUrl;
      withoutChildren(imgContainer).appendChild(img);
      img.onload = () => {
        URL.revokeObjectURL(dataUrl);
        renderSelf(--numPasses);
      };
    })
    .catch((error) => {
      console.error("dom-to-image error: ", error);
      const errorMsg = document.createElement("p");
      errorMsg.innerText = "a PNG image containing the document body should appear here but conversion failed";
      imgContainer.appendChild(errorMsg);
    });
}

window.onload = (_) => renderSelf(2);
