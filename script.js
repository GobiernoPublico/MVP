
function navigate(page) {
  window.location.href = page;
}

document.addEventListener('DOMContentLoaded', () => {
  const chartCanvas = document.getElementById('comparisonChart');
  if (chartCanvas) {
    new Chart(chartCanvas, {
      type: 'bar',
      data: {
        labels: ['Propuesta A', 'Propuesta B', 'Propuesta C'],
        datasets: [{
          label: 'Votos .com',
          data: [60, 40, 80],
          backgroundColor: '#333'
        }, {
          label: 'Votos .org',
          data: [70, 55, 65],
          backgroundColor: '#aaa'
        }]
      },
      options: {
        responsive: true,
        scales: {
          y: {
            beginAtZero: true
          }
        }
      }
    });
  }
});
