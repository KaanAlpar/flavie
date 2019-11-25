import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['card', 'article']

  connect() {
    this.showCard()
  }

  showCard() {
    this.cardTargets.forEach((el, i) => {
      el.classList.toggle("flashcard--current", this.index == i)
    })
  }

  next() {
    if (this.index === this.maxFlashcardIndex )
      this.articleTargets.forEach((el) => {
        el.classList.toggle('d-none');
      })
    else if (this.index < this.maxFlashcardIndex) {
      this.index++
    }
  }

  previous() {
    if (this.index > 0) {
      this.index--
    }
  }

  get index() {
    return parseInt(this.data.get('index'), 10)
  }

  get maxFlashcardIndex() {
    return parseInt(this.data.get('max-number'), 10) - 1
  }

  set index(value) {
    this.data.set('index', value)
    this.showCard()
  }
}
