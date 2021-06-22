import { Controller } from "stimulus";
import $ from 'jquery';

export default class extends Controller {
  static targets = [ "source", "filterable" ]

  filter() {
    let lowerCaseFilterTerm = this.sourceTarget.value.toLowerCase();

    this.filterableTargets.forEach((el, i) => {
      let filterableKey =  el.getAttribute("data-filter-key")

      el.parentNode.classList.toggle("filter--notFound", !filterableKey.includes( lowerCaseFilterTerm ) )
    })


    // TODO: fix parallax
    // const visibleTargets = this.filterableTargets.filter(el => !el.parentNode.classList.contains('filter--notFound'));
    // visibleTargets.forEach((element, index) => {
    //   const parallaxFactor = index % 3 === 1 ? 0.5 : 0; // Targets the middle column
    //   $(element).paroller({
    //     factor: parallaxFactor,
    //     type: 'foreground'
    //   });
    // });

  }
}
