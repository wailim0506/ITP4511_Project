function setDarkModePreference() {
    if ($('#darkModeToogle').text() == 'brightness_2') {
        //to dark mode
        $('#html').attr('data-bs-theme', 'dark');
        $('#darkModeToogle').text('wb_sunny');
        localStorage.setItem('darkMode', 'Y');
    } else {
        //to light mode
        $('#html').attr('data-bs-theme', 'light');
        $('#darkModeToogle').text('brightness_2');
        localStorage.setItem('darkMode', 'N');
    }
    updateDarkModeToggleStyle();
};

function updateDarkModeToggleStyle() {
    if ($('#html').attr('data-bs-theme') === 'dark') {
        $('#darkModeToogle').css('background-color', '#343a40');
    } else {
        $('#darkModeToogle').css('background-color', '#f8f9fa');
    }
}

function loadDarkModePreference() {
    if (localStorage.getItem('darkMode') != null) {
        if (localStorage.getItem('darkMode') == 'Y') {
            $('#html').attr('data-bs-theme', 'dark');
            $('#darkModeToogle').text('wb_sunny');
        } else {
            $('#html').attr('data-bs-theme', 'light');
            $('#darkModeToogle').text('brightness_2');
        }
    }
    updateDarkModeToggleStyle();
}

loadDarkModePreference();
$(document).ready(function () {
    loadDarkModePreference();
    $('#darkModeToogle').click(function () {
        setDarkModePreference();
    });
});


