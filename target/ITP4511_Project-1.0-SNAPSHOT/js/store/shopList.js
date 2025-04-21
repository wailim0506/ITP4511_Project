/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

$(document).ready(function () {
    // Initialize shop count
    updateShopCount();

    // Handle search functionality
    $("#shopSearch").on("keyup", filterShops);

    // Handle country filter
    $("#countryFilter").on("change", filterShops);

    // Handle city filter
    $("#cityFilter").on("change", filterShops);

    // Handle reset button
    $("#resetFilterBtn").on("click", function () {
        $("#shopSearch").val("");
        $("#countryFilter").val("all");
        $("#cityFilter").val("all");
        filterShops();
    });

    // Dark mode functionality is now handled by darkModeControl.js

    // Function to filter shops based on search text and filters
    function filterShops() {
        const searchText = $("#shopSearch").val().toLowerCase();
        const countryFilter = $("#countryFilter").val();
        const cityFilter = $("#cityFilter").val();

        $(".shopItem").each(function () {
            const shopId = $(this).data("shop-id").toLowerCase();
            const shopCountry = $(this).data("country");
            const shopCity = $(this).data("city");

            const matchesSearch = shopId.includes(searchText);
            const matchesCountry = countryFilter === "all" || shopCountry === countryFilter;
            const matchesCity = cityFilter === "all" || shopCity === cityFilter;

            if (matchesSearch && matchesCountry && matchesCity) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });

        updateShopCount();
    }

    // Function to update the shop count display
    function updateShopCount() {
        const totalShops = $(".shopItem").length;
        const visibleShops = $(".shopItem:visible").length;

        $("#visibleShopCount").text(visibleShops);
        $("#totalShopCount").text(totalShops);
        $(".shopCount").text(totalShops + " Shops");

        if (visibleShops < totalShops) {
            $(".shopResultInfo").removeClass("d-none");
        } else {
            $(".shopResultInfo").addClass("d-none");
        }
    }
});
