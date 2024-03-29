import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["icon"]

  toggle () {
    if (this.iconTarget.classList.contains('fas')) {
      this.iconTarget.classList = "far fa-heart"
    }
    else {
      this.iconTarget.classList = "fas fa-heart"
    }
  }
}
