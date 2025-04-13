function renderOrderChart(orderData) {
    const labels = orderData.map(item => item.date);
    const data = orderData.map(item => item.total);

    const ctx = document.getElementById('orderChart').getContext('2d');
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: 'Orders per Day',
                data: data,
                borderColor: 'rgba(75, 192, 192, 1)',
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                fill: true,
                tension: 0.4
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    title: { display: true, text: 'Number of Orders' },
                    ticks: { stepSize: 1 }
                },
                x: {
                    title: { display: true, text: 'Date' }
                }
            }
        }
    });
}