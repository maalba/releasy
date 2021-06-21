import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["Music", "TV Shows", "Movies", "Podcasts", "Sneakers", "Devices", "Books"],
    typeSpeed: 200,
    loop: true
  });
}

export { loadDynamicBannerText };
