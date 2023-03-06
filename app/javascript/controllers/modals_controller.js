import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modals"
export default class extends Controller {
  connect() {
    const modal = document.getElementById('modal')
    this.element.addEventListener('turbo:submit-end', (e) => {
      if (e.detail.success) {
        modal.innerHTML = ''
        modal.removeAttribute('src')
        modal.removeAttribute('complete')
      }
    })

    const pattern_input = document.getElementById('pattern_input')
    const brand_input = document.getElementById('brand_input')
    pattern_input.value = ''
    brand_input.value = ''
  }

  close(e) {
    const modal = document.getElementById('modal')
    modal.innerHTML = ''
    modal.removeAttribute('src')
    modal.removeAttribute('complete')
  }
}
