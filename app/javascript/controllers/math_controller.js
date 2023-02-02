import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="math"
export default class extends Controller {
  static targets = ['dateToday', 'qty', 'total', 'price', 'netPrice', 'withOutDDV', 'ddv', 'productInput', 'customer', 'warehouse']
  static values = { 
    controller: String,
    doc: String
  }

  connect() {
    this.dateTodayTarget.value = new Date().toLocaleDateString('en-CA')
    let warehouse = this.warehouseTarget.value
    let doc = this.controllerValue
    this.warehouse_fecth(warehouse, doc)
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

  set_warehouse(event) {
    let warehouse_id = event.target.value
    let doc = this.controllerValue
    this.warehouse_fecth(warehouse_id, doc)
  }

  warehouse_fecth(warehouse_id, doc) {
    fetch(`/document?warehouse_id=${warehouse_id}&doc=${doc}`, { headers: { accept: "application/json" } })
    .then(response => response.json())
    .then((data) => {
      document.getElementById('invoice_number').value = data.document_number
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

  set_price(event) {
    let price_id = this.result(event.target.id)
    let price_field = `${this.controllerValue}_documents_attributes_${price_id}_price`
    fetch(`/products/?product_id=${event.target.value}`, { headers: { accept: "application/json" } })
    .then(response => response.json())
    .then((data) => {
      document.getElementById(price_field).value = data.retail_price
    })
  }

  set_customer_due_days(event) {
    let customer_id = this.customerTarget.value
    fetch(`/customers/?customer_id=${customer_id}`, { headers: { accept: "application/json" } })
    .then(response => response.json())
    .then((data) => {
      document.getElementById('invoice_due_days').value = data.due
    })

  }


}





