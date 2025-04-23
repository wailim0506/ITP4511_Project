/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
function filterTable() {
    const orderIdFilter = document.getElementById("orderIdFilter").value.toLowerCase();
    const statusFilter = document.getElementById("statusFilter").value;
    const dateFilter = document.getElementById("dateFilter").value;
    const table = document.querySelector(".order-table tbody");
    const rows = table.getElementsByTagName("tr");

    for (let i = 0; i < rows.length; i++) {
        const cells = rows[i].getElementsByTagName("td");
        const orderId = cells[0].textContent.toLowerCase();
        const status = cells[4].textContent;
        const orderDate = new Date(cells[1].textContent);

        const now = new Date();
        let dateMatch = true;

        if (dateFilter === "currentMonth") {
            dateMatch = orderDate.getFullYear() === now.getFullYear() && orderDate.getMonth() === now.getMonth();
        } else if (dateFilter === "last90Days") {
            const daysAgo90 = new Date();
            daysAgo90.setDate(now.getDate() - 90);
            dateMatch = orderDate >= daysAgo90 && orderDate <= now;
        } else if (dateFilter === "yearToDate") {
            dateMatch = orderDate.getFullYear() === now.getFullYear();
        }

        const orderIdMatch = orderId.includes(orderIdFilter);
        const statusMatch = statusFilter === "" || status === statusFilter;

        if (orderIdMatch && statusMatch && dateMatch) {
            rows[i].style.display = "";
        } else {
            rows[i].style.display = "none";
        }
    }
}

function resetFilters() {
    document.getElementById("orderIdFilter").value = "";
    document.getElementById("statusFilter").value = "";
    document.getElementById("dateFilter").value = "";
    filterTable();
}

