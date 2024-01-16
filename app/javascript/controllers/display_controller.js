import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="display"
export default class extends Controller {
  static targets = ["chart", "list"]

  connect() {
    this.showChart()
  }

  showChart() {
    this.chartTarget.style.display = 'block'
    this.listTarget.style.display = 'none'
  }

  showList() {
    this.chartTarget.style.display = 'none'
    this.listTarget.style.display = 'block'
  }
}