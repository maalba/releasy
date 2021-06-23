const shrinkArtistName = () => {
  const artistNames = document.querySelectorAll(".shrinkable");
  artistNames.forEach((name) => {
    const textStyle = getComputedStyle(name.firstElementChild);
    let fontSize = parseInt(textStyle.fontSize.match(/\d+/)[0]);
    while(name.firstElementChild.offsetWidth > 240) {
      name.firstElementChild.style.fontSize = `${--fontSize}px`;
    }
  })
}

export { shrinkArtistName }