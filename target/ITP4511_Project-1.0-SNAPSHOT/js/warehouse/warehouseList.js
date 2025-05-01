/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

$(document).ready(function () {
    // Initialize shop count
    updateWarehouseCount();

    // Handle search functionality
    $("#warehouseSearch").on("keyup", filterWarehouse);

    // Handle country filter
    $("#countryFilter").on("change", filterWarehouse);

    // Handle city filter
    $("#cityFilter").on("change", filterWarehouse);

    // Handle reset button
    $("#resetFilterBtn").on("click", function () {
        $("#warehouseSearch").val("");
        $("#countryFilter").val("all");
        $("#cityFilter").val("all");
        filterWarehouse();
    });

    // Dark mode functionality is now handled by darkModeControl.js

    // Function to filter shops based on search text and filters
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

    // Function to update the shop count display
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

