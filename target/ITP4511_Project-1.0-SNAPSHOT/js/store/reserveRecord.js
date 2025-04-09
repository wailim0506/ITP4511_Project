/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

$(document).ready(function () {
    // Initialize tooltips
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));

    // Filter records based on search input
    $("#recordSearch").on("input", function () {
        filterRecords();
    });

    // Filter records based on status selection
    $("#statusFilter").on("change", function () {
        filterRecords();
    });

    // Filter records based on date range
    $("#dateRangeFilter").on("change", function () {
        filterRecords();
    });

    // Reset all filters
    $("#resetFilterBtn").on("click", function () {
        $("#recordSearch").val("");
        $("#statusFilter").val("all");
        $("#dateRangeFilter").val("all");
        filterRecords();
    });

    // Show record details modal when view button is clicked
    $(".btn-outline-primary").on("click", function (e) {
        e.preventDefault();
        $("#recordDetailsModal").modal("show");
    });

    // Function to filter records based on search input and filters
    function filterRecords() {
        const searchText = $("#recordSearch").val().toLowerCase();
        const statusFilter = $("#statusFilter").val();
        const dateFilter = $("#dateRangeFilter").val();

        let visibleCount = 0;
        const totalCount = $(".reserveRecordItem").length;

        $(".reserveRecordItem").each(function () {
            const orderId = $(this).find("td:first-child span").text().toLowerCase();
            const dateCreated = $(this).find("td:nth-child(2)").text().toLowerCase();
            const status = $(this).find("td:nth-child(5) span").text().toLowerCase();

            // Check if record matches search text
            const matchesSearch = orderId.includes(searchText) || dateCreated.includes(searchText);

            // Check if record matches status filter
            const matchesStatus = statusFilter === "all" || status.toLowerCase() === statusFilter.toLowerCase();

            // Check if record matches date filter (simplified for demo)
            const matchesDate = dateFilter === "all" ||
                (dateFilter === "current" && dateCreated.includes("2025-04")) ||
                (dateFilter === "last" && dateCreated.includes("2025-03")) ||
                (dateFilter === "lastThree" && (
                    dateCreated.includes("2025-04") ||
                    dateCreated.includes("2025-03") ||
                    dateCreated.includes("2025-02")
                ));

            // Show/hide record based on filters
            if (matchesSearch && matchesStatus && matchesDate) {
                $(this).show();
                visibleCount++;
            } else {
                $(this).hide();
            }
        });

        // Update record count information
        $("#visibleRecordsCount").text(visibleCount);
        $("#totalRecordsCount").text(totalCount);
    }
});


