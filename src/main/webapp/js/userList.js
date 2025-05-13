/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

$(document).ready(function () {
    $("#userSearch").on("keyup", filterUsers);

    $("#roleFilter").on("change", filterUsers);

    $('#placeIdFilter').on('change', filterUsers);

    $("#resetFilterBtn").on("click", function () {
        window.location.href = '/ITP4511_Project/userList';
    });

    $('.deleteUserBtn').on('click', function () {
        var userId = $(this).data('user-id');
        if (confirm(`Are you sure you want to delete this user ${userId}?\nThis action cannot be revert.`)) {
            window.location.href = `/ITP4511_Project/userList?action=del&id=${userId}`;
        }
    });

    $('.editUserBtn').on('click', function () {
        var userId = $(this).data('user-id');
        window.location.href = `/ITP4511_Project/userList?action=edit&id=${userId}`;
    });

    function filterUsers() {
        const searchText = $("#userSearch").val().toLowerCase();
        const roleFilter = $("#roleFilter").val();
        const placeIdFilter = $("#placeIdFilter").val();

        $(".user").each(function () {
            const userId = $(this).data("user-id").toLowerCase();
            const role = $(this).data("role");
            const placeId = $(this).data("place-id");

            const matchesSearch = userId.includes(searchText);
            const matchesRole = roleFilter === "all" || role === roleFilter;
            const matchesPlaceId = placeIdFilter === "all" || placeId === placeIdFilter;

            if (matchesSearch && matchesRole && matchesPlaceId) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });

        updateShopCount();
    }

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
