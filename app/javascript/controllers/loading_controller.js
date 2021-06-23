import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["follow", "done"]

  followSpinner() {
    this.followTarget.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Working'
  }

  doneSpinner() {
    this.doneTarget.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Working'
  }
}
