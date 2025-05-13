/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

$(document).ready(function () {
    getCutOffDate();
    const collectionDateElement = $('#collectionDate');
    const dateText = collectionDateElement.text();

    if (dateText && dateText.trim() !== '') {
        try {
            const date = new Date(dateText);
            if (!isNaN(date.getTime())) {
                const formattedDate = new Intl.DateTimeFormat('en-US', {
                    year: 'numeric',
                    month: 'long',
                    day: 'numeric'
                }).format(date);
                collectionDateElement.text(formattedDate);
            }
        } catch (e) {
            console.error("Error formatting date:", e);
        }
    }

    localStorage.removeItem('fruitQuantities');
    localStorage.removeItem('fruitName');
    localStorage.removeItem('fruitUnit');

    function getCutOffDate() {
        const currentDate = new Date();
        const currentMonth = currentDate.getMonth();
        const currentYear = currentDate.getFullYear();

        const lastDayOfMonth = new Date(currentYear, currentMonth + 1, 0).getDate();

        if (currentDate <= new Date(currentYear, currentMonth, 14)) {
            collectDay = 15;
        }
        else {
            collectDay = lastDayOfMonth;
        }

        const collectDate = new Date(currentYear, currentMonth, collectDay);
        const formattedDate = collectDate.toISOString().slice(0, 10);

        $("#reserveCollectDate").text(formattedDate);
    }
});


