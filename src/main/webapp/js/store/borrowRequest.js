/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

$(document).ready(function () {

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

    $("#statusFilter").on("change", function () {
        let selectedStatus = $(this).val();

        if (selectedStatus === "all") {
            $(".requestItem").show();
            $("tbody tr").show();
        } else {
            if (selectedStatus === "pending") {
                $(".requestItem").show();
            } else {
                $(".requestItem").hide();
            }

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

    $("#dateFilter").on("change", function () {
        let selectedDate = $(this).val();

        if (!selectedDate) {
            $(".requestItem").show();
            $("tbody tr").show();
            return;
        }

        const selectedDateObj = selectedDate ? new Date(selectedDate) : null;

        if (!selectedDateObj) {
            $(".requestItem").show();
            $("tbody tr").show();
            return;
        }

        const formattedSelectedDate = selectedDateObj.toISOString().split('T')[0];

        $(".requestItem").each(function () {
            const requestDate = $(this).data('request-date');
            if (requestDate === formattedSelectedDate) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });

        $("tbody tr").each(function () {
            const rowDate = $(this).data('request-date');
            if (rowDate === formattedSelectedDate) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    });
});


