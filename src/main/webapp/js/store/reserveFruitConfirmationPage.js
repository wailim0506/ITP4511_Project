/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

$(document).ready(function () {
    getCutOffDate();
    // Format the collection date if it's provided in ISO format
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

    // Clear any localStorage data related to reservation
    localStorage.removeItem('fruitQuantities');
    localStorage.removeItem('fruitName');
    localStorage.removeItem('fruitUnit');

    function getCutOffDate() {
        // Set reserveCollectDate to either the 14th or last day of the month
        const currentDate = new Date();
        const currentMonth = currentDate.getMonth();
        const currentYear = currentDate.getFullYear();

        // Calculate the last day of current month
        const lastDayOfMonth = new Date(currentYear, currentMonth + 1, 0).getDate();

        if (currentDate <= new Date(currentYear, currentMonth, 14)) {
            collectDay = 15;
        }
        else {
            collectDay = lastDayOfMonth;
        }

        const collectDate = new Date(currentYear, currentMonth, collectDay);
        const formattedDate = collectDate.toISOString().slice(0, 10);

        // Change from .val() to .text() as we're working with a paragraph element, not an input
        $("#reserveCollectDate").text(formattedDate);
    }
});


