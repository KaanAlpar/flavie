const flashcardFlip = () => {
  $( '#js-flip-1' ).click(function() {
            $('#js-flip-1 .card').addClass('flipped');
  });
}

export { flashcardFlip };
