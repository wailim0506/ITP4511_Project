/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

$(document).ready(function () {
    // Initialize tooltips
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));

    $("#recordSearch").on("input", function () {
        filterById();
    });

    $("#statusFilter").on("change", function () {
        filterByStatusOrDateRange();
    });

    $("#dateRangeFilter").on("change", function () {
        filterByStatusOrDateRange();
    });

    $("#resetFilterBtn").on("click", function () {
        window.location.href = "/ITP4511_Project/reserveRecord?action=listAll"
    });

    $(".btn-outline-primary").on("click", function (e) {
        e.preventDefault();
        $("#recordDetailsModal").modal("show");
    });

    $('.editBtn').on('click', function () {
        var tableRow = $(this).closest('.modal-body').find('tbody tr');
        tableRow.each(function () {
            $(this).find('.readQty').toggleClass('d-none');
            $(this).find('.editQty').toggleClass('d-none');
        });

        var modal = $(this).closest('.modal');
        modal.find('.modal-footer .submitBtn').toggleClass('d-none');
        modal.find('.addItem').toggleClass('d-none');

        var theadtr = modal.find('thead tr');
        theadtr.find('.actionCol').toggleClass('d-none');
        $(this).toggleClass('d-none');

    });

    $('.deleteItemBtn').on('click', function () {
        var row = $(this).closest('tr');
        row.remove(); // Remove the row from the table
    });


    // Rebind delete functionality for dynamically added rows
    $(document).on('click', '.deleteItemBtn', function () {
        $(this).closest('tr').remove();
    });

    $('.addNewItemBtn').on('click', function () {
        const modal = $(this).closest('.modal'); // Scope to the specific modal
        const selectedFruit = modal.find('.newFruitSelect option:selected');
        const fruitId = selectedFruit.val();
        const fruitName = selectedFruit.data('name');
        const fruitOrigin = selectedFruit.data('origin');
        const fruitUnit = selectedFruit.data('unit');
        const fruitQty = modal.find('.newFruitQty').val();

        if (!fruitId || !fruitQty || fruitQty <= 0) {
            alert('Please select a fruit and enter a valid quantity.');
            return;
        }

        const newRow = `
            <tr>
                <td>${fruitName}</td>
                <td>${fruitOrigin}</td>
                <td class='readQty d-none'>${fruitQty}</td>
                <td class='editQty'>
                    <input class="form-control w-50 h-25" value="${fruitQty}" name="${fruitId}" min="0" type="number" required>
                </td>
                <td>${fruitUnit}</td>
                <td class='editQty'>
                    <button type="button" class="btn btn-danger btn-sm deleteItemBtn">
                        <i class="material-icons small">delete</i>
                    </button>
                </td>
            </tr>
        `;
        modal.find('tbody.orderItemsTable').append(newRow); // Append the new row to the correct table body
        modal.find('.newFruitSelect').val(''); // Reset the selection box
        modal.find('.newFruitQty').val(''); // Reset the quantity input
    });

    // Rebind delete functionality for dynamically added rows
    $(document).on('click', '.deleteItemBtn', function () {
        $(this).closest('tr').remove();
    });

    function filterById() {
        const searchText = $("#recordSearch").val().toLowerCase();

        $(".reserveRecordItem").each(function () {
            const orderId = $(this).find("td:first-child span").text().toLowerCase();

            const matchesSearch = orderId.includes(searchText);

            if (matchesSearch) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    }

    function filterByStatusOrDateRange() {
        var url;
        var status = $("#statusFilter").val();
        var dateRange = $("#dateRangeFilter").val();

        if (status === "all" && dateRange === "all") {
            url = "/ITP4511_Project/reserveRecord?action=listAll";
        } else if (status === "all" && dateRange !== "all") {
            url = "/ITP4511_Project/reserveRecord?action=listByDateRange&dateRange=" + dateRange;
        } else if (status !== "all" && dateRange === "all") {
            url = "/ITP4511_Project/reserveRecord?action=listByStatus&status=" + status;
        } else {
            url = "/ITP4511_Project/reserveRecord?action=listByBoth&status=" + status + "&dateRange=" + dateRange;
        }

        window.location.href = url;
    }
});


