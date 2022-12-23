import { Controller } from "@hotwired/stimulus"
import SlimSelect from "slim-select"
// import "slim-select/dist/slimselect.min.css"

// Connects to data-controller="slim"
export default class extends Controller {
  connect() {
    new SlimSelect({
      
      select: this.element,
      settings: {
        showSearch: true,
        selected: true,
        searchText: 'пребарај',
        searchPlaceholder: '',
        searchHighlight: true,
        placeholderText: 'Select an option'
      },
      
    });
  } 
}
