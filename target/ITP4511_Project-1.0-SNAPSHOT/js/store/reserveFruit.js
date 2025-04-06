/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


$(document).ready(function () {
    if (!localStorage.getItem('fruitQuantities') || !localStorage.getItem('fruitName') || !localStorage.getItem('fruitUnit')) {
        InitializeLocalStorage();
    } else {
        fillInputBoxWithLocalStorage();
    }

    // Set min and max date for date input
    const today = new Date();
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);

    const maxDate = new Date(today);
    maxDate.setDate(maxDate.getDate() + 14);

    // Format dates for HTML date input: YYYY-MM-DD
    const formatDate = (date) => {
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        return `${year}-${month}-${day}`;
    };

    $('#deliveryDate').attr('min', formatDate(tomorrow));
    $('#deliveryDate').attr('max', formatDate(maxDate));

    // Update summary when quantity changes
    $('input[type=number]').on('change', function () {
        updateLocalStorage();
        updateSummary();
    });

    // Search and filter functionality
    $('#fruitSearch').on('input', function () {
        filterFruits();
    });

    $('#countryFilter').on('change', function () {
        filterByCountryRegion();
    });

    $('#typeFilter').on('change', function () {
        filterByFruitType();
    });

    $("#resetFilterBtn").on("click", function () {
        var url = "/ITP4511_Project/reserveFruit?action=listAll";
        window.location.href = url;
    });

    $("#resetFormBtn").on("click", function () {
        localStorage.removeItem('fruitQuantities');
        localStorage.removeItem('fruitName');
        localStorage.removeItem('fruitUnit');
        var url = "/ITP4511_Project/reserveFruit?action=listAll";
        window.location.href = url;
    });

    $("#reservationForm").on("submit", function (event) {
        event.preventDefault();
        localStorage.removeItem('fruitQuantities'); // Clear local storage
        localStorage.removeItem('fruitName'); // Clear local storage
        localStorage.removeItem('fruitUnit'); // Clear local storage
        this.submit();
    });

    // Initialize fruit count and summary
    updateFruitCount();
    updateSummary();

    function filterFruits() {
        var searchText = $('#fruitSearch').val().toLowerCase();
        var country = $('#countryFilter').val();

        $('.fruit-item').each(function () {
            var fruitName = $(this).data('fruit-name').toLowerCase();
            var fruitCategory = $(this).data('category');

            var matchesSearch = fruitName.includes(searchText);
            var matchesCountry = country === 'all' || fruitCategory === country;

            if (matchesSearch && matchesCountry) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });

        updateFruitCount();
    }

    function filterByCountryRegion() {
        filterByFruitType();
    }

    function filterByFruitType() {
        var type = $('#typeFilter').val();
        var cr = $('#countryFilter').val();
        var url;
        if (type === 'all' && cr === 'all') {
            url = '/ITP4511_Project/reserveFruit?action=listAll';
        } else if (type === 'all' && cr !== 'all') {
            url = `/ITP4511_Project/reserveFruit?action=listByCountryRegion&cr=${cr}`;
        } else if (cr === 'all' && type !== 'all') {
            url = `/ITP4511_Project/reserveFruit?action=listByType&type=${type}`;
        } else {
            url = `/ITP4511_Project/reserveFruit?action=listByBoth&cr=${cr}&type=${type}`;
        }
        window.location.href = url;
    }

    function updateFruitCount() {
        var totalFruits = $('.fruit-item').length;
        var visibleFruits = $('.fruit-item:visible').length;

        $('#visibleFruitCount').text(visibleFruits);
        $('#totalFruitCount').text(totalFruits);

        if (visibleFruits < totalFruits) {
            $('.fruit-results-info').removeClass('d-none');
        } else {
            $('.fruit-results-info').addClass('d-none');
        }
    }

    function updateSummary() {
        let summary = '';
        let totalItems = 0;

        const fruitQuantities = JSON.parse(localStorage.getItem('fruitQuantities')) || {};
        const fruitNames = JSON.parse(localStorage.getItem('fruitName')) || {};
        const fruitUnits = JSON.parse(localStorage.getItem('fruitUnit')) || {};


        //loop fruitQuantities to get fruit information
        for (const fruitId in fruitQuantities) {
            const qty = fruitQuantities[fruitId] || 0;
            if (qty > 0) {
                const fruitName = fruitNames[fruitId];
                const unit = fruitUnits[fruitId];
                summary += `<div class="d-flex justify-content-between mb-2">
                                <span>${fruitName}</span>   
                                <span>${qty} ${unit}</span>
                            </div>`;
                totalItems += qty;
            }
        }


        if (summary === '') {
            $('#reservationSummary').html('<p class="text-muted text-center py-4">No items selected yet</p>');
        } else {
            $('#reservationSummary').html(summary);
        }

        $('#totalItems').text(totalItems);
    }

    // Also save when using search filter
    $('#fruitSearch').on('input', function () {
        filterFruits();
        // No need to save here as we're not reloading the page
    });

    function InitializeLocalStorage() {
        // Initialize local storage for fruit quantities
        var fruits = {};

        // Loop through all fruit quantity inputs
        $('input[type=number]').each(function () {
            var inputName = $(this).data('name');
            // Extract fruit ID from the input name pattern "fruit_X_qty"
            if (inputName && inputName.startsWith('fruit_')) {
                var fruitId = inputName.split('_')[1];
                fruits[fruitId] = 0;
            }
        });

        // Store in localStorage if needed
        localStorage.setItem('fruitQuantities', JSON.stringify(fruits));

        var fruitsName = {};
        //store all fruit name
        $('input[type=number]').each(function () {
            var inputName = $(this).data('name');
            // Extract fruit ID from the input name pattern "fruit_X_qty"
            if (inputName && inputName.startsWith('fruit_')) {
                var fruitId = inputName.split('_')[1];
                var fruitName = $(this).closest('.fruit-item').find('h5').text();
                fruitsName[fruitId] = fruitName;
            }
        });
        // Store in localStorage if needed
        localStorage.setItem('fruitName', JSON.stringify(fruitsName));

        //store fruit unit
        var fruitsUnit = {};
        //store all fruit unit
        $('input[type=number]').each(function () {
            var inputName = $(this).data('name');
            // Extract fruit ID from the input name pattern "fruit_X_qty"
            if (inputName && inputName.startsWith('fruit_')) {
                var fruitId = inputName.split('_')[1];
                var unit = $(this).data('unit');
                fruitsUnit[fruitId] = unit;
            }
        });
        // Store in localStorage if needed
        localStorage.setItem('fruitUnit', JSON.stringify(fruitsUnit));
    }

    function updateLocalStorage() {
        // Update local storage with current fruit quantities
        var fruits = JSON.parse(localStorage.getItem('fruitQuantities')) || {};

        // Loop through all fruit quantity inputs
        $('input[type=number]').each(function () {
            var inputName = $(this).data('name');
            // Extract fruit ID from the input name pattern "fruit_X_qty"
            if (inputName && inputName.startsWith('fruit_')) {
                var fruitId = inputName.split('_')[1];
                var qty = parseInt($(this).val()) || 0;
                fruits[fruitId] = qty;
            }
        });

        // Store in localStorage
        localStorage.setItem('fruitQuantities', JSON.stringify(fruits));
    }

    function fillInputBoxWithLocalStorage() {
        // Fill input boxes with values from local storage
        var fruits = JSON.parse(localStorage.getItem('fruitQuantities')) || {};

        // Loop through all fruit quantity inputs
        $('input[type=number]').each(function () {
            var inputName = $(this).data('name');
            // Extract fruit ID from the input name pattern "fruit_X_qty"
            if (inputName && inputName.startsWith('fruit_')) {
                var fruitId = inputName.split('_')[1];
                var qty = fruits[fruitId] || 0;
                $(this).val(qty);
            }
        });
    }
});