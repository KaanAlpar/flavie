const initUpdateNavbarOnScroll = () => {
  const navbar = document.querySelector('.circular-menu');
  if (navbar) {
    window.addEventListener('scroll', () => {
      if (window.scrollY >= 200) {
        navbar.classList.remove('circular-menu');
      } else {
        navbar.classList.add('inline-block-menu');
      }
    });
  }
}

export { initUpdateNavbarOnScroll };
