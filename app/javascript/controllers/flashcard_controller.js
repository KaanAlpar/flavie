import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['card'];

  flip() {
    this.element.classList.toggle('flashcard--flipped')
  }
}
