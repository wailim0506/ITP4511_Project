function setDarkModePreference(){
    if ($('#darkModeToogle').text() == 'brightness_2') {
        //to dark mode
        $('#html').attr('data-bs-theme','dark');
        $('#darkModeToogle').text('wb_sunny');
        localStorage.setItem('darkMode', 'Y');

    }else{
        //to light mode
        $('#html').attr('data-bs-theme','light');
        $('#darkModeToogle').text('brightness_2');
        localStorage.setItem('darkMode', 'N');
    }
};

function loadDarkModePreference(){
    if (localStorage.getItem('darkMode') != null){
        if (localStorage.getItem('darkMode') == 'Y'){
            $('#html').attr('data-bs-theme','dark');
            $('#darkModeToogle').text('wb_sunny');
        }else{
            $('#html').attr('data-bs-theme','light');
            $('#darkModeToogle').text('brightness_2');
        }
    }
}
loadDarkModePreference();
$(document).ready(function(){
    loadDarkModePreference();
    $('#darkModeToogle').click(function() {
        setDarkModePreference();
    });
});


