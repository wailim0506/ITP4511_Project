/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

$(document).ready(function () {
    updateFruitCount();
    hideAllFruitSections();

    $("#shopFilter").change(function () {
        let selectedShopId = $(this).val();
        $("#selectedShopId").val(selectedShopId);
        let selectedShopName = $("#shopFilter option:selected").text();
        $("#selectedShopName").text(selectedShopName);

        hideAllFruitSections();
        showSelectedShopFruits(selectedShopId);
        $("#fruitSelectionSection").removeClass("d-none");

        $("input[type='number']").val(0);
        $("#requestSummary").html('<p class="text-muted text-center py-4">No items selected yet</p>');

        updateFruitCount();
    });

    $("#fruitSearch").on("keyup", filterFruits);
    $("#typeFilter").on("change", filterFruits);

    $("input[type='number']").on("change", function () {
        updateRequestSummary();
    });

    $("#resetFormBtn").click(function () {
        resetForm();
    });

    function filterFruits() {
        let searchText = $('#fruitSearch').val().toLowerCase();
        let type = $('#typeFilter').val();
        let shopId = $('#shopFilter').val();

        $(`.fruitItem[data-shop="${shopId}"]`).each(function () {
            let fruitName = $(this).data('fruit-name').toLowerCase();
            let fruitType = $(this).data('type').toLowerCase();
            let availability = parseInt($(this).find('.text-success').text()) || 0;

            let matchesSearch = fruitName.includes(searchText);
            let matchesType = type === 'all' || fruitType.includes(type.toLowerCase());
            let isAvailable = availability > 0;

            if (matchesSearch && matchesType && isAvailable) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });

        updateFruitCount();
    }

    function hideAllFruitSections() {
        $(".fruitItem").hide();
    }

    function showSelectedShopFruits(shopId) {
        $(`.fruitItem[data-shop="${shopId}"]`).show();
    }

    function updateFruitCount() {
        let totalFruits = $(".fruitItem[data-shop='" + $("#shopFilter").val() + "']").length;
        let visibleFruits = $(".fruitItem[data-shop='" + $("#shopFilter").val() + "']:visible").length;

        $("#totalFruitCount").text(totalFruits);
        $("#visibleFruitCount").text(visibleFruits);
    }

    function updateRequestSummary() {
        let summary = "";
        let totalItems = 0;

        $("input[type='number']").each(function () {
            let qty = parseInt($(this).val());
            if (qty > 0) {
                let itemInfo = $(this).closest(".fruitItem");
                let fruitName = itemInfo.find("h5").text();
                let unit = itemInfo.find(".text-success").text().split(" ")[1];

                summary += `<div class="d-flex justify-content-between mb-2">
                                <span>${fruitName} (${qty} ${unit})</span>
                                <span>${qty}</span>
                            </div>`;
                totalItems += qty;
            }
        });

        if (totalItems > 0) {
            $("#requestSummary").html(summary);
        } else {
            $("#requestSummary").html('<p class="text-muted text-center py-4">No items selected yet</p>');
        }

        $("#totalItems").text(totalItems);
    }

    function resetForm() {
        $("input[type='number']").val(0);

        $("#fruitSearch").val("");
        $("#typeFilter").val("all");

        updateRequestSummary();

        filterFruits();
    }
});


