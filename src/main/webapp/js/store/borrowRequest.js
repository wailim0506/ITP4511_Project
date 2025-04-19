/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

$(document).ready(function () {

    // Handle request search filtering
    $("#requestSearch").on("keyup", function () {
        let searchText = $(this).val().toLowerCase();

        $(".requestItem").each(function () {
            let shopName = $(this).find("p:contains('Sweet')").text().toLowerCase();
            let requestId = $(this).find("h6").text().toLowerCase();
            let notes = $(this).find("p.text-muted.small").text().toLowerCase();
            let fruits = $(this).find(".fruitRequestList").text().toLowerCase();

            if (shopName.includes(searchText) || requestId.includes(searchText) ||
                notes.includes(searchText) || fruits.includes(searchText)) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    });

    // Handle status filter
    $("#statusFilter").on("change", function () {
        let selectedStatus = $(this).val();

        if (selectedStatus === "all") {
            $(".requestItem").show();
            $("tbody tr").show();
        } else {
            // For pending requests section
            if (selectedStatus === "pending") {
                $(".requestItem").show();
            } else {
                $(".requestItem").hide();
            }

            // For request history table
            $("tbody tr").each(function () {
                let status = $(this).find("td:nth-child(4) .badge").text().toLowerCase();

                if (status === selectedStatus) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        }
    });

    // Handle date filter
    $("#dateFilter").on("change", function () {
        let selectedDate = $(this).val();

        if (!selectedDate) {
            $(".requestItem").show();
            $("tbody tr").show();
            return;
        }

        // This is just for UI demo purposes
        // In a real implementation, you would compare actual dates
        // Get the selected date and convert to Date object
        const selectedDateObj = selectedDate ? new Date(selectedDate) : null;

        if (!selectedDateObj) {
            $(".requestItem").show();
            $("tbody tr").show();
            return;
        }

        // Format selected date to YYYY-MM-DD for comparison
        const formattedSelectedDate = selectedDateObj.toISOString().split('T')[0];

        // Filter pending requests section
        $(".requestItem").each(function () {
            const requestDate = $(this).data('request-date');
            if (requestDate === formattedSelectedDate) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });

        // Filter history table
        $("tbody tr").each(function () {
            const rowDate = $(this).data('request-date');
            if (rowDate === formattedSelectedDate) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    });

    // Pass request ID to modals
    // $('#requestDetailsModal').on('show.bs.modal', function (event) {
    //     let button = $(event.relatedTarget);
    //     let requestId = button.data('request-id');
    //     let modal = $(this);

    //     modal.find('.modal-title').text('Request Details: #' + requestId);

    //     // In a real implementation, you would fetch and display the specific request details here
    // });

    // $('#approveModal').on('show.bs.modal', function (event) {
    //     let button = $(event.relatedTarget);
    //     let requestId = button.data('request-id');
    //     let modal = $(this);

    //     modal.find('.modal-title').text('Approve Request #' + requestId);
    // });

    // $('#rejectModal').on('show.bs.modal', function (event) {
    //     let button = $(event.relatedTarget);
    //     let requestId = button.data('request-id');
    //     let modal = $(this);

    //     modal.find('.modal-title').text('Reject Request #' + requestId);
    // });
});


