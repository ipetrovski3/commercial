import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js";

// Connects to data-controller="select"
export default class extends Controller {
  static targets = ["patternSelect"]
  change(event) {
    let brand_value = event.target.value
    let target = this.patternSelectTarget.id

    get(`/products/brands?target=${target}&brand=${brand_value}`, {
      responseKind: "turbo-stream",
    })
  }
}
