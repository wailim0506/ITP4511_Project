function updateClock() {
    const now = new Date();

    // Format date: Monday, April 30, 2025
    const dateOptions = {
        weekday: 'long',
        year: 'numeric',
        month: 'long',
        day: 'numeric'
    };
    const dateStr = now.toLocaleDateString('en-US', dateOptions);

    // Format time using same locale-based formatting as the date
    const timeOptions = {
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit',
        hour12: false
    };
    const timeStr = now.toLocaleTimeString('en-US', timeOptions);

    // Update the content
    document.getElementById('current-time').innerHTML = dateStr + ' ' + timeStr + '</span>';
}

// Update the clock immediately
updateClock();

// Update the clock every second
setInterval(updateClock, 1000);

