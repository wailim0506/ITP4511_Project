/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

$(document).ready(function () {

    $('.cityFilterContainer').hide();

    function updateFilterVisibility() {
        var viewLevel = $('#viewLevel').val();
        if (viewLevel === 'city') {
            $('.cityFilterContainer').show();
            $('#countryFilterContainer').hide();
            $('.shopFilterContainer').hide();
        } else if (viewLevel === 'c') {
            $('.cityFilterContainer').hide();
            $('#countryFilterContainer').show();
            $('.shopFilterContainer').hide();
        } else {
            $('.cityFilterContainer').hide();
            $('#countryFilterContainer').hide();
            $('.shopFilterContainer').show();
        }
    }

    updateFilterVisibility();

    $('#filterButtonContainer').on('click', function () {
        window.location.href = '/ITP4511_Project/reserveNeed?viewLevel=c&cn=all&date=last12Months';
    });

    // Dynamically update UI when view level changes
    $('#viewLevel').on('change', function () {
        updateFilterVisibility();
        var viewLevel = $(this).val();
        var country = $('#countryFilter').val();
        var city = $('#cityFilter').val();
        var shop = $('#shopFilter').val();
        var dateRange = $('#dateRangeFilter').val();
        var url = '';
        if (viewLevel === 'c') {
            url = `/ITP4511_Project/reserveNeed?viewLevel=${viewLevel}&cn=${country}&date=${dateRange}`;
        }
        else if (viewLevel === 'city') {
            url = `/ITP4511_Project/reserveNeed?viewLevel=${viewLevel}&city=${city}&date=${dateRange}`;
        } else {
            url = `/ITP4511_Project/reserveNeed?viewLevel=shop&shop=${shop}&date=${dateRange}`;
        }
        window.location.href = url;
    });

    // Show/hide custom date range based on selection
    $('#dateRangeFilter').on('change', function () {
        var viewLevel = $('#viewLevel').val();
        var country = $('#countryFilter').val();
        var city = $('#cityFilter').val();
        var shop = $('#shopFilter').val();
        var dateRange = $(this).val();
        var url = '';
        if (viewLevel === 'c') {
            url = `/ITP4511_Project/reserveNeed?viewLevel=${viewLevel}&cn=${country}&date=${dateRange}`;
        }
        else if (viewLevel === 'city') {
            url = `/ITP4511_Project/reserveNeed?viewLevel=${viewLevel}&city=${city}&date=${dateRange}`;
        } else {
            url = `/ITP4511_Project/reserveNeed?viewLevel=shop&shop=${shop}&date=${dateRange}`;
        }

        window.location.href = url;
    });

    $('#cityFilter').on('change', function () {
        var viewLevel = $('#viewLevel').val();
        var city = $(this).val();
        var dateRange = $('#dateRangeFilter').val();
        var url = '';
        if (viewLevel === 'c') {
            url = `/ITP4511_Project/reserveNeed?viewLevel=${viewLevel}&cn=${country}&date=${dateRange}`;
        }
        else if (viewLevel === 'city') {
            url = `/ITP4511_Project/reserveNeed?viewLevel=${viewLevel}&city=${city}&date=${dateRange}`;
        } else {
            //url = `/ITP4511_Project/reserveNeed?viewLevel=${viewLevel}&cn=${country}&date=${dateRange}`;
        }

        window.location.href = url;
    });

    // Handle country filter changes - would update city dropdown options in real implementation
    $('#countryFilter').on('change', function () {
        var viewLevel = $('#viewLevel').val();
        var country = $(this).val();
        var dateRange = $('#dateRangeFilter').val();

        url = `/ITP4511_Project/reserveNeed?viewLevel=${viewLevel}&cn=${country}&date=${dateRange}`;
        window.location.href = url;
    });

    $('#shopFilter').on('change', function () {
        var viewLevel = $('#viewLevel').val();
        var shop = $(this).val();
        var dateRange = $('#dateRangeFilter').val();
        var url = '';
        if (viewLevel === 'c') {
            url = `/ITP4511_Project/reserveNeed?viewLevel=${viewLevel}&cn=${country}&date=${dateRange}`;
        }
        else if (viewLevel === 'city') {
            url = `/ITP4511_Project/reserveNeed?viewLevel=${viewLevel}&city=${city}&date=${dateRange}`;
        } else {
            url = `/ITP4511_Project/reserveNeed?viewLevel=shop&shop=${shop}&date=${dateRange}`;
        }

        window.location.href = url;
    });
});




