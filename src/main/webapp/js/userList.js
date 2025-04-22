/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

$(document).ready(function () {
    // Initialize shop count
    //updateShopCount();

    // Handle search functionality
    $("#userSearch").on("keyup", filterUsers);

    // Handle country filter
    $("#roleFilter").on("change", filterUsers);

    // Handle reset button
    $("#resetFilterBtn").on("click", function () {
        $("#userSearch").val("");
        $("#roleFilter").val("all");
    });

    // Dark mode functionality is now handled by darkModeControl.js

    // Function to filter shops based on search text and filters
    function filterUsers() {
        const searchText = $("#userSearch").val().toLowerCase();
        const roleFilter = $("#roleFilter").val();

        $(".user").each(function () {
            const userId = $(this).data("user-id").toLowerCase();
            const role = $(this).data("role");

            const matchesSearch = userId.includes(searchText);
            const matchesRole = roleFilter === "all" || role === roleFilter;

            if (matchesSearch && matchesRole) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });

        updateShopCount();
    }

    // Function to update the shop count display
    function updateShopCount() {
        const totalShops = $(".user").length;
        const visibleShops = $(".user:visible").length;

        $("#visibleUserCount").text(visibleShops);
        $("#totalUserCount").text(totalShops);

        if (visibleShops < totalShops) {
            $(".userResultInfo").removeClass("d-none");
        } else {
            $(".userResultInfo").addClass("d-none");
        }
    }
});
