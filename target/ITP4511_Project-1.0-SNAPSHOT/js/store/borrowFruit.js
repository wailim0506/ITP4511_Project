/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

$(document).ready(function () {
    // Set min date for return date (today + 1 day)
    const today = new Date();
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);

    // Max date (today + 7 days)
    const maxDate = new Date(today);
    maxDate.setDate(maxDate.getDate() + 7);

    // Format dates for HTML date input: YYYY-MM-DD
    const formatDate = (date) => {
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        return `${year}-${month}-${day}`;
    };

    $('#returnDate').attr('min', formatDate(tomorrow));
    $('#returnDate').attr('max', formatDate(maxDate));

    // Initialize - hide all fruits
    $('.fruitItem').hide();
    updateFruitCount();
    updateRequestSummary();

    // Shop selection functionality
    $('#shopFilter').on('change', function () {
        const shopId = $(this).val();
        const shopName = $(this).find('option:selected').text().split('(')[0].trim();

        // Show fruits only if a shop is selected
        if (shopId) {
            // Set selected shop in hidden field and display
            $('#selectedShopId').val(shopId);
            $('#selectedShopName').text(shopName);

            // Show fruit selection section
            $('#fruitSelectionSection').removeClass('d-none');

            // Filter fruits by shop
            $('.fruitItem').hide();
            $(`.fruitItem[data-shop="${shopId}"]`).show();

            // Update fruit count
            updateFruitCount();
        } else {
            // Hide fruit selection section if no shop is selected
            $('#fruitSelectionSection').addClass('d-none');
        }
    });

    // Back to shop selection
    $('#backToShopSelection').on('click', function () {
        $('#fruitSelectionSection').addClass('d-none');
        $('#shopSelectionSection').removeClass('d-none');

        // Reset filters
        $('#fruitSearch').val('');
        $('#typeFilter').val('all');
    });

    // Fruit search and filter functionality
    $('#fruitSearch').on('input', function () {
        filterFruits();
    });

    $('#typeFilter').on('change', function () {
        filterFruits();
    });

    // Reset form
    $('#resetFormBtn').on('click', function () {
        $('input[type=number]').val(0);
        $('#borrowingForm')[0].reset();
        updateRequestSummary();
    });

    // Add to request functionality
    $('.addToRequestBtn').on('click', function () {
        const qtyInput = $(this).closest('.d-flex').find('input[type=number]');
        const currentVal = parseInt(qtyInput.val());

        if (currentVal > 0) {
            // In a real application, this would add the item to the request
            updateRequestSummary();
        } else {
            alert('Please enter a quantity greater than 0');
        }
    });

    // Update quantity and request summary when input changes
    $('input[type=number]').on('change', function () {
        updateRequestSummary();
    });

    // Filter fruits based on search and filter criteria
    function filterFruits() {
        let searchText = $('#fruitSearch').val().toLowerCase();
        let type = $('#typeFilter').val();
        let shopId = $('#selectedShopId').val();

        // Only filter visible shop's fruits
        $(`.fruitItem[data-shop="${shopId}"]`).each(function () {
            let fruitName = $(this).data('fruit-name').toLowerCase();
            let fruitType = $(this).find('p:contains("Type:")').text().toLowerCase();
            let availabilityText = $(this).find('span.text-success').text();
            let availability = parseInt(availabilityText) || availabilityText.length > 0;

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

    // Update the visible fruit count
    function updateFruitCount() {
        let shopId = $('#selectedShopId').val();
        if (!shopId) return;

        let totalFruits = $(`.fruitItem[data-shop="${shopId}"]`).length;
        let visibleFruits = $(`.fruitItem[data-shop="${shopId}"]:visible`).length;

        $('#visibleFruitCount').text(visibleFruits);
        $('#totalFruitCount').text(totalFruits);
    }

    // Update the request summary in the sidebar
    function updateRequestSummary() {
        let summary = '';
        let totalItems = 0;

        $('input[type=number]').each(function () {
            let qty = parseInt($(this).val()) || 0;
            if (qty > 0) {
                let fruitName = $(this).closest('.fruitItem').find('h5').text();
                let unit = $(this).closest('.fruitItem').find('span.text-success').text().split(' ')[1];

                summary += `<div class="d-flex justify-content-between mb-2">
                                <span>${fruitName}</span>
                                <span>${qty} ${unit}</span>
                            </div>`;
                totalItems += qty;
            }
        });

        if (summary === '') {
            $('#requestSummary').html('<p class="text-muted text-center py-4">No items selected yet</p>');
        } else {
            $('#requestSummary').html(summary);
        }

        $('#totalItems').text(totalItems);
    }
});


