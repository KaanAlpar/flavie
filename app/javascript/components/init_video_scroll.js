const initVideoScroll = () => {
  const video = document.querySelector('.results-video')
  const flashcard = document.querySelector('.flashcards-home-container')

  window.addEventListener('scroll', (event) => {
    var scrollPos = window.scrollY || window.scrollTop || document.getElementsByTagName("html")[0].scrollTop
    if (scrollPos > 315) {
      video.classList.add('results-video--fixed')
      flashcard.classList.add('flashcards-home-container--fixed')
    } else {
      video.classList.remove('results-video--fixed')
      flashcard.classList.remove('flashcards-home-container--fixed')
    }
  })
}


export { initVideoScroll };
