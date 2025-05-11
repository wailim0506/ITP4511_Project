/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

document.addEventListener('DOMContentLoaded', function() {
    const fruitData = window.fruitData || [];
    const canvas = document.createElement('canvas');
    canvas.id = 'fruitPieChart';
    canvas.width = 600;
    canvas.height = 400;
    document.querySelector('.pieChart').appendChild(canvas);
    
    const ctx = canvas.getContext('2d');
    const totalSum = fruitData.reduce((sum, fruit) => sum + fruit.total, 0);
    const colors = ['#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4', '#FFEEAD', '#D4A5A5'];
    
    let startAngle = 0;
    fruitData.forEach((fruit, index) => {
        const sliceAngle = (fruit.total / totalSum) * 2 * Math.PI;
        
        // Draw pie slice
        ctx.beginPath();
        ctx.moveTo(200, 200);
        ctx.arc(200, 200, 150, startAngle, startAngle + sliceAngle);
        ctx.fillStyle = colors[index % colors.length];
        ctx.fill();
        
        // Calculate angles for label and connector line
        const textAngle = startAngle + sliceAngle / 2;
        const labelDistance = 180; 
        const lineStartDistance = 150;
        const lineMidDistance = 165;
        
        // Calculate positions
        const lineStartX = 200 + Math.cos(textAngle) * lineStartDistance;
        const lineStartY = 200 + Math.sin(textAngle) * lineStartDistance;
        const lineMidX = 200 + Math.cos(textAngle) * lineMidDistance;
        const lineMidY = 200 + Math.sin(textAngle) * lineMidDistance;
        const textX = 200 + Math.cos(textAngle) * labelDistance;
        const textY = 200 + Math.sin(textAngle) * labelDistance;
        
        // Draw connector line
        ctx.beginPath();
        ctx.moveTo(lineStartX, lineStartY);
        ctx.lineTo(lineMidX, lineMidY);
        ctx.lineTo(textX, textY);
        ctx.strokeStyle = '#000';
        ctx.lineWidth = 1;
        ctx.stroke();
        
        // Draw label
        ctx.fillStyle = '#000';
        ctx.font = '14px Arial'; 
        ctx.textBaseline = 'middle';
        ctx.textAlign = textAngle > Math.PI ? 'right' : 'left';
        ctx.fillText(`${fruit.name} (${Math.round(fruit.total/totalSum*100)}%)`, textX, textY);
        
        startAngle += sliceAngle;
    });
    
    ctx.fillStyle = '#000';
    ctx.font = '18px Arial'; 
    ctx.textAlign = 'center';
});