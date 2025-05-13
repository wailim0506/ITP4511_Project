/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

$(document).ready(function () {
    updateWarehouseCount();

    $("#warehouseSearch").on("keyup", filterWarehouse);

    $("#countryFilter").on("change", filterWarehouse);

    $("#cityFilter").on("change", filterWarehouse);

    $("#resetFilterBtn").on("click", function () {
        $("#warehouseSearch").val("");
        $("#countryFilter").val("all");
        $("#cityFilter").val("all");
        filterWarehouse();
    });


    function filterWarehouse() {
        const searchText = $("#warehouseSearch").val().toLowerCase();
        const countryFilter = $("#countryFilter").val();
        const cityFilter = $("#cityFilter").val();

        $(".warehouseItem").each(function () {
            const shopId = $(this).data("warehouse-id").toLowerCase();
            const warehouseCountry = $(this).data("country");
            const warehouseCity = $(this).data("city");

            const matchesSearch = shopId.includes(searchText);
            const matchesCountry = countryFilter === "all" || warehouseCountry === countryFilter;
            const matchesCity = cityFilter === "all" || warehouseCity === cityFilter;

            if (matchesSearch && matchesCountry && matchesCity) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });

        updateWarehouseCount();
    }

    function updateWarehouseCount() {
        const totalWarehouse = $(".warehouseItem").length;
        const visibleWarehouse = $(".warehouseItem:visible").length;

        $("#visibleWarehouseCount").text(visibleWarehouse);
        $("#totalWarehouseCount").text(totalWarehouse);
        $(".shopCount").text(totalWarehouse + " Warehouse");

        if (visibleWarehouse < totalWarehouse) {
            $(".warehouseResultInfo").removeClass("d-none");
        } else {
            $(".warehouseResultInfo").addClass("d-none");
        }
    }
});

