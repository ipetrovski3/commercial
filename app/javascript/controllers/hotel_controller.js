import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hotel"
export default class extends Controller {
  static targets = ['tireFields', 'tires']
  connect() {
  }

  addTireFields() {
    this.tiresTarget.insertAdjacentHTML('beforeend', this.tireFieldsTarget.innerHTML)
    console.log(this.tireFieldsTarget)
  }
}
