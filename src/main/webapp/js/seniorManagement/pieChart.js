/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

document.addEventListener('DOMContentLoaded', function () {
    const fruitData = window.fruitData || [];
    const pieCanvas = document.createElement('canvas');
    pieCanvas.id = 'fruitPieChart';
    pieCanvas.width = 500;
    pieCanvas.height = 400;
    document.querySelector('.pieChart').appendChild(pieCanvas);

    const pieCtx = pieCanvas.getContext('2d');
    const totalSum = fruitData.reduce((sum, fruit) => sum + fruit.total, 0);
    const colors = ['#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4', '#FFEEAD', '#D4A5A5'];

    let startAngle = 0;
    fruitData.forEach((fruit, index) => {
        const sliceAngle = (fruit.total / totalSum) * 2 * Math.PI;

        pieCtx.beginPath();
        pieCtx.moveTo(200, 200);
        pieCtx.arc(200, 200, 150, startAngle, startAngle + sliceAngle);
        pieCtx.fillStyle = colors[index % colors.length];
        pieCtx.fill();

        const textAngle = startAngle + sliceAngle / 2;
        const labelDistance = 180;
        const lineStartDistance = 150;
        const lineMidDistance = 165;

        const lineStartX = 200 + Math.cos(textAngle) * lineStartDistance;
        const lineStartY = 200 + Math.sin(textAngle) * lineStartDistance;
        const lineMidX = 200 + Math.cos(textAngle) * lineMidDistance;
        const lineMidY = 200 + Math.sin(textAngle) * lineMidDistance;
        const textX = 200 + Math.cos(textAngle) * labelDistance;
        const textY = 200 + Math.sin(textAngle) * labelDistance;

        pieCtx.beginPath();
        pieCtx.moveTo(lineStartX, lineStartY);
        pieCtx.lineTo(lineMidX, lineMidY);
        pieCtx.lineTo(textX, textY);
        pieCtx.strokeStyle = '#000';
        pieCtx.lineWidth = 1;
        pieCtx.stroke();

        pieCtx.fillStyle = '#000';
        pieCtx.font = '14px Arial';
        pieCtx.textBaseline = 'middle';
        pieCtx.textAlign = textAngle > Math.PI ? 'right' : 'left';
        pieCtx.fillText(`${fruit.name} (${Math.round(fruit.total / totalSum * 100)}%)`, textX, textY);

        startAngle += sliceAngle;
    });

    pieCtx.fillStyle = '#000';
    pieCtx.font = '18px Arial';
    pieCtx.textAlign = 'center';

    const lineCanvas = document.createElement('canvas');
    lineCanvas.id = 'fruitLineChart';
    lineCanvas.width = 700;
    lineCanvas.height = 400;
    document.querySelector('.lineChart').appendChild(lineCanvas);

    const lineCtx = lineCanvas.getContext('2d');
    const maxTotal = Math.max(...fruitData.map(fruit => fruit.total));
    const yScale = (maxTotal > 0) ? (300 / maxTotal) : 1;
    const xStep = 600 / (fruitData.length + 1);

    lineCtx.beginPath();
    lineCtx.moveTo(50, 50);
    lineCtx.lineTo(50, 350);
    lineCtx.lineTo(650, 350);
    lineCtx.strokeStyle = '#000';
    lineCtx.lineWidth = 2;
    lineCtx.stroke();

    const yTicks = 5;
    for (let i = 0; i <= yTicks; i++) {
        const yValue = (maxTotal / yTicks) * i;
        const yPos = 350 - (yValue * yScale);
        lineCtx.fillStyle = '#000';
        lineCtx.font = '12px Arial';
        lineCtx.textAlign = 'right';
        lineCtx.fillText(Math.round(yValue), 45, yPos);
    }

    lineCtx.beginPath();
    lineCtx.strokeStyle = '#FF6B6B';
    lineCtx.lineWidth = 2;
    fruitData.forEach((fruit, index) => {
        const x = 50 + (index + 1) * xStep;
        const y = 350 - (fruit.total * yScale);

        if (index === 0) {
            lineCtx.moveTo(x, y);
        } else {
            lineCtx.lineTo(x, y);
        }

        lineCtx.fillStyle = '#000';
        lineCtx.font = '12px Arial';
        lineCtx.textAlign = 'center';
        lineCtx.fillText(fruit.name, x, 370);
    });
    lineCtx.stroke();

    fruitData.forEach((fruit, index) => {
        const x = 50 + (index + 1) * xStep;
        const y = 350 - (fruit.total * yScale);
        lineCtx.beginPath();
        lineCtx.arc(x, y, 4, 0, 2 * Math.PI);
        lineCtx.fillStyle = '#FF6B6B';
        lineCtx.fill();
    });

    lineCtx.fillStyle = '#000';
    lineCtx.font = '18px Arial';
    lineCtx.textAlign = 'center';
});