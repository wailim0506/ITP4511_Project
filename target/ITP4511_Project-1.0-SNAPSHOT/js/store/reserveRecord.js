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


