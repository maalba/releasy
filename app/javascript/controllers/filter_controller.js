import { Controller } from "stimulus";
import $ from 'jquery';
import Shuffle from 'shufflejs'


export default class extends Controller {
  static targets = [ "source", "container" ]

  connect() {
    this.shuffle = new Shuffle(this.containerTarget, {
      itemSelector: '.artist-card-filterable',
      // sizer: sizer // could also be a selector: '.my-sizer-element'
    });
  }
  
  filter() {
    let lowerCaseFilterTerm = this.sourceTarget.value.toLowerCase();
    console.log(lowerCaseFilterTerm)

    // this.filterableTargets.forEach((el, i) => {
    //   let filterableKey =  el.getAttribute("data-filter-key")
    //     el.parentNode.classList.toggle("filter--notFound", !filterableKey.includes( lowerCaseFilterTerm ) )
    // })
    this.shuffle.filter(function (element) {
      let artistName =  element.getAttribute("data-filter-key");
      return artistName.includes( lowerCaseFilterTerm );
    });
  }
}
