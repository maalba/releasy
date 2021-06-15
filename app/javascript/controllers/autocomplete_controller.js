import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "query" ]
  connect() {
    console.log(this.queryTarget);
  }

  refresh() {
    console.log(this.queryTarget.value);
  }
}