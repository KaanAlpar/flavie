import { Controller } from "stimulus"

export default class extends Controller {
  toggleEdit () {
    const editFront = document.getElementById('frontInput');
    const frontSelectWord = document.getElementById('frontSelectWord');
    editFront.classList.toggle('d-none');
    frontSelectWord.classList.toggle('d-none');
  }
}
