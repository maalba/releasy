import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  const typedTextEl = document.querySelector('#banner-typed-text');
  if (typedTextEl) {
    new Typed(typedTextEl, {
      strings: ["Music", "TV Shows", "Movies", "Podcasts", "Sneakers", "Aldi Specials", "Drag Shows", "Books"],
      typeSpeed: 200,
      loop: true
    });
  }
}

export { loadDynamicBannerText };
