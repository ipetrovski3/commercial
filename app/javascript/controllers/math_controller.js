import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="math"
export default class extends Controller {
  static targets = ['dateToday', 'qty', 'total', 'price', 'netPrice', 'withOutDDV', 'ddv', 'productInput', 'customer']
  static values = { controller: String }

  connect() {
    this.dateTodayTarget.value = new Date().toLocaleDateString('en-CA')
    let collection = this.productInputTargets
    let customer = this.customerTarget

    if (customer.value != "") {
      fetch(`/customers/?customer_id=${customer.value}`, { headers: { accept: "application/json" } })
      .then(response => response.json())
      .then((data) => {
        document.getElementById('customer_input').value = (data.name)
      })
    }
    
    collection.forEach(function(input) {
      let row = input.dataset.row
      if (input.value == "") {
        return 
      } else {
        let product_id = input.value
        fetch(`/products/?product_id=${product_id}`, { headers: { accept: "application/json" } })
        .then(response => response.json())
        .then((data) => {
          document.getElementById(`input_${row}`).value = (data.dimension + ' ' +  data.name)
        })
      }
    })
  }

  change_qty(event) {
    let result = this.result(event.target.id)
    let price_field = `${this.controllerValue}_documents_attributes_${result}_price`
    let total_field = `${this.controllerValue}_documents_attributes_${result}_total_price`

    let qty = event.target.value
    let price = document.getElementById(price_field).value
    let total = qty * price

    document.getElementById(total_field).value = total
    this.totals()
  }

  change_price(event) {
    let result = this.result(event.target.id)

    let qty_field = `${this.controllerValue}_documents_attributes_${result}_qty`
    let total_field = `${this.controllerValue}_documents_attributes_${result}_total_price`

    let price = event.target.value
    let qty = document.getElementById(qty_field).value
    let total = qty * price

    document.getElementById(total_field).value = total
    this.totals()
  }

  result(target_id) {
    let regex = /(\d+)/g
    let result = target_id.match(regex)
    return result[0]
  }

  totals()  {
    let total_inputs = document.querySelectorAll('.sum_field')
    let sum = 0
    total_inputs.forEach(function(input) {
      sum += Number(input.value)
    })
    let withOutDDV = (sum / 1.18).toFixed(2)
    let ddv = (sum - withOutDDV).toFixed(2)
    this.netPriceTarget.innerHTML = sum + ' ден.'
    this.withOutDDVTarget.innerHTML = withOutDDV + ' ден.'
    this.ddvTarget.innerHTML = ddv + ' ден.'
  }


}





