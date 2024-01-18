import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="inss-discount"
export default class extends Controller {
  static targets = [ "salary", "discount" ]

  calculate() {
    console.log('calculate');
    fetch(`/proponents/inss_discount?salary=${this.salaryTarget.value}`)
      .then(response => response.json())
      .then(data => {
        this.discountTarget.value = data.inss_discount;
      });
  }
}
