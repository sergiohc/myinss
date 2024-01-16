import { Controller } from "@hotwired/stimulus"
import Chart from 'chart.js/auto';

export default class extends Controller {
  connect() {
    this.loadChart();
  }

  loadChart() {
    var ctx = this.element.querySelector('canvas').getContext('2d');
    this.chart = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: JSON.parse(this.data.get('labels')),
        datasets: [{
          label: 'Salary',
          data: JSON.parse(this.data.get('data')),
          backgroundColor: 'rgba(75, 192, 192, 0.2)',
          borderColor: 'rgba(75, 192, 192, 1)',
          borderWidth: 1
        }]
      },
      options: {
        scales: {
          y: {
            beginAtZero: true
          }
        }
      }
    });
  }
}