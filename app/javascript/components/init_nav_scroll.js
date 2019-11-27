const initNavScroll = () => {
  const navbar = document.querySelector('.navbar')
  navbar.querySelectorAll('.purple-li').forEach((item) => {
    item.classList.add('white-li')
    item.classList.remove('purple-li')
  })
  window.addEventListener('scroll', (event) => {
    var scrollPos = window.scrollY || window.scrollTop || document.getElementsByTagName("html")[0].scrollTop
    if (scrollPos > 200) {
      navbar.style.backgroundColor = "#FAFAFA"
      navbar.querySelectorAll('.white-li').forEach((item) => {
        item.classList.add('purple-li')
        item.classList.remove('white-li')
      })
    } else {
      navbar.style.backgroundColor = ""
      navbar.querySelectorAll('.purple-li').forEach((item) => {
        item.classList.add('white-li')
        item.classList.remove('purple-li')
      })
    };
  })
}

export { initNavScroll };
