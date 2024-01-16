import { Controller } from "@hotwired/stimulus"
import Chart from 'chart.js/auto';

// Connects to data-controller="chart"
export default class extends Controller {
  connect() {
    this.loadChart();
  }

  loadChart() {
    const ctx = document.getElementById('myChart');
    const labels = JSON.parse(this.element.dataset.chartLabels);
    const data = JSON.parse(this.element.dataset.chartData);

    this.chart = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: labels.map(label => label.range),
        datasets: [{
          label: '# Total',
          data: data,
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