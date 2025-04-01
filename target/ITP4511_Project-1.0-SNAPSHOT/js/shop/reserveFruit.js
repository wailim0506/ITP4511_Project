/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


$(document).ready(function () {
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
        updateSummary();
    });

    // Search and filter functionality
    $('#fruitSearch').on('input', function () {
        filterFruits();
    });

    $('#countryFilter').on('change', function () {
        filterFruits();
    });

    // Initialize fruit count
    updateFruitCount();

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

        $('input[type=number]').each(function () {
            let qty = parseInt($(this).val());
            if (qty > 0) {
                let fruitName = $(this).closest('.fruit-item').find('h5').text();
                summary += `<div class="d-flex justify-content-between mb-2">
                                          <span>${fruitName}</span>
                                          <span>${qty} pc</span>
                                       </div>`;
                totalItems += qty;
            }
        });

        if (summary === '') {
            $('#reservationSummary').html('<p class="text-muted text-center py-4">No items selected yet</p>');
        } else {
            $('#reservationSummary').html(summary);
        }

        $('#totalItems').text(totalItems + ' pc');
    }
});