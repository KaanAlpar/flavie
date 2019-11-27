import { Controller } from "stimulus"

export default class extends Controller {
  toggleEdit () {
    const editFront = document.getElementById('frontInput');
    const flashcardEditFront = document.querySelector('.flashcard-edit-front')
    editFront.classList.toggle('d-none');
    flashcardEditFront.classList.toggle('d-none');
  }
}
