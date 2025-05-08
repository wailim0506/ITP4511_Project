/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

$(document).ready(function () {
    // Initialize UI components and listeners
    initializeFilters();
    initializeTableHeader();

    // Handle filter form submission
    $('#filterForm').on('submit', function (e) {
        e.preventDefault();
        applyFilters();
    });

    // Dynamically update UI when view level changes
    $('#viewLevel').on('change', function () {
        updateViewLevelUI($(this).val());
    });

    // Show/hide custom date range based on selection
    $('#dateRangeFilter').on('change', function () {
        if ($(this).val() === 'custom') {
            $('.customDateRangeContainer').removeClass('d-none');
        } else {
            $('.customDateRangeContainer').addClass('d-none');
        }
    });

    // Handle country filter changes - would update city dropdown options in real implementation
    $('#countryFilter').on('change', function () {
        updateCityOptions($(this).val());
    });

    // Initialize any charts/visualizations
    initializeCharts();

    // Dark mode toggle
    $('#darkModeToogle').on('click', function () {
        toggleDarkMode();
    });

    // Initialize view based on selected option
    updateView();

    // Handle view level change
    $('#viewLevel').on('change', function () {
        updateView();
    });

    // Show/hide custom date range based on date range filter selection
    $('#dateRangeFilter').on('change', function () {
        if ($(this).val() === 'custom') {
            $('.customDateRangeContainer').removeClass('d-none');
        } else {
            $('.customDateRangeContainer').addClass('d-none');
        }
    });

    // Show/hide city filter based on country selection
    $('#countryFilter').on('change', function () {
        const countryVal = $(this).val();

        if (countryVal !== 'all') {
            $('.cityFilterContainer').show();

            // Filter cities based on selected country
            $('#cityFilter option').hide();
            $('#cityFilter option[value="all"]').show();

            if (countryVal === 'Japan') {
                $('#cityFilter option[value="Tokyo"]').show();
                $('#cityFilter option[value="Osaka"]').show();
            } else if (countryVal === 'USA') {
                $('#cityFilter option[value="New York"]').show();
                $('#cityFilter option[value="Los Angeles"]').show();
            } else if (countryVal === 'Hong Kong') {
                $('#cityFilter option[value="Hong Kong Island"]').show();
                $('#cityFilter option[value="Kowloon"]').show();
            }

            // Reset city filter to "All Cities"
            $('#cityFilter').val('all');
        } else {
            $('.cityFilterContainer').hide();
        }
    });

    // Initially hide city filter
    $('.cityFilterContainer').hide();

    // Handle filter form submission
    $('#filterForm').on('submit', function (e) {
        e.preventDefault();

        // In a real application, this would send an AJAX request to the server
        // For demonstration, we'll just show an alert
        alert('Filters applied! In a real application, this would refresh the data.');
    });

    // Function to update the view based on selected level
    function updateView() {
        const viewLevel = $('#viewLevel').val();

        // Hide all tables first
        $('.reserveNeedTable').addClass('d-none');

        // Show the appropriate table and update title based on view level
        switch (viewLevel) {
            case 'country':
                $('#countryView').removeClass('d-none');
                $('#tableTitleText').text('Reservation Needs by Country');
                break;
            case 'city':
                $('#cityView').removeClass('d-none');
                $('#tableTitleText').text('Reservation Needs by City');
                break;
            case 'shop':
                $('#shopView').removeClass('d-none');
                $('#tableTitleText').text('Reservation Needs by Shop');
                break;
        }
    }
});

/**
 * Set up initial filter states and visibility
 */
function initializeFilters() {
    // Set default dates if needed
    const today = new Date();
    const lastMonth = new Date();
    lastMonth.setMonth(today.getMonth() - 1);

    // Format dates for date inputs
    const formatDate = (date) => {
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        return `${year}-${month}-${day}`;
    };

    $('#startDate').val(formatDate(lastMonth));
    $('#endDate').val(formatDate(today));
}

/**
 * Update the table header text based on the selected view level
 */
function initializeTableHeader() {
    updateTableHeader($('#viewLevel').val());
}

/**
 * Update the table header text based on the selected view level
 * @param {string} viewLevel - The selected view level (country, city, shop)
 */
function updateTableHeader(viewLevel) {
    let headerText = 'Reservation Needs by ';

    switch (viewLevel) {
        case 'city':
            headerText += 'City';
            break;
        case 'shop':
            headerText += 'Shop';
            break;
        default:
            headerText += 'Country';
    }

    $('#resultsTableHeader').text(headerText);
}

/**
 * Update the UI based on the selected view level
 * @param {string} viewLevel - The selected view level (country, city, shop)
 */
function updateViewLevelUI(viewLevel) {
    updateTableHeader(viewLevel);

    // In a real implementation, this would trigger different data views
    // and potentially adjust the table columns

    // For demonstration purposes, just update the table header
    console.log('View level changed to:', viewLevel);
}

/**
 * Update city dropdown options based on the selected country
 * @param {string} country - The selected country
 */
function updateCityOptions(country) {
    const citySelect = $('#cityFilter');
    citySelect.empty();
    citySelect.append('<option value="all" selected>All Cities</option>');

    // In a real implementation, this would fetch cities from the server
    // based on the selected country. For demo purposes, we'll hard-code some options.

    if (country === 'Japan') {
        citySelect.append('<option value="Tokyo">Tokyo</option>');
        citySelect.append('<option value="Osaka">Osaka</option>');
        citySelect.append('<option value="Kyoto">Kyoto</option>');
    } else if (country === 'USA') {
        citySelect.append('<option value="New York">New York</option>');
        citySelect.append('<option value="Los Angeles">Los Angeles</option>');
        citySelect.append('<option value="Chicago">Chicago</option>');
    } else if (country === 'Hong Kong') {
        citySelect.append('<option value="Hong Kong Island">Hong Kong Island</option>');
        citySelect.append('<option value="Kowloon">Kowloon</option>');
        citySelect.append('<option value="New Territories">New Territories</option>');
    }
}

/**
 * Apply the selected filters and update the display
 */
function applyFilters() {
    // In a real implementation, this would make an AJAX request to fetch filtered data
    const viewLevel = $('#viewLevel').val();
    const country = $('#countryFilter').val();
    const city = $('#cityFilter').val();
    const dateRange = $('#dateRangeFilter').val();

    // For demo purposes, just log the filter values
    console.log('Applying filters:', {
        viewLevel,
        country,
        city,
        dateRange
    });

    // Show a loading indicator
    showLoadingState();

    // In a real implementation, this would be an AJAX call with a callback
    // For demo purposes, simulate a delay then update the UI
    setTimeout(function () {
        // Update UI with "new data"
        hideLoadingState();

        // Show a success message
        showFilterSuccessMessage();
    }, 800);
}

/**
 * Show loading state on the UI
 */
function showLoadingState() {
    // In a real implementation, this would show a loading spinner or overlay
    $('button[type="submit"]').prop('disabled', true).html(
        '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Loading...'
    );
}

/**
 * Hide loading state on the UI
 */
function hideLoadingState() {
    // In a real implementation, this would hide the loading spinner
    $('button[type="submit"]').prop('disabled', false).html(
        '<i class="material-icons align-middle me-2">search</i>Apply Filters'
    );
}

/**
 * Show a success message after filters are applied
 */
function showFilterSuccessMessage() {
    // In a real implementation, this would show a success message
    const alertDiv = $('<div class="alert alert-success alert-dismissible fade show" role="alert"></div>');
    alertDiv.html(`
        <i class="material-icons align-middle me-2 small">check_circle</i>
        Filters applied successfully!
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    `);

    // Add the alert before the results section and remove it after 3 seconds
    $('.headerSection').after(alertDiv);

    setTimeout(function () {
        alertDiv.alert('close');
    }, 3000);
}

/**
 * Initialize chart visualizations
 */
function initializeCharts() {
    // In a real implementation, this would initialize charts using a library like Chart.js
    // For the demo, we're using CSS for visual representations
    console.log('Charts would be initialized here in a real implementation');
}


