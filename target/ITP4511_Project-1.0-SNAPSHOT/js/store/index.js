function updateClock() {
    const now = new Date();

    const dateOptions = {
        weekday: 'long',
        year: 'numeric',
        month: 'long',
        day: 'numeric'
    };
    const dateStr = now.toLocaleDateString('en-US', dateOptions);

    const timeOptions = {
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit',
        hour12: false
    };
    const timeStr = now.toLocaleTimeString('en-US', timeOptions);

    document.getElementById('current-time').innerHTML = dateStr + ' ' + timeStr + '</span>';
}

updateClock();

setInterval(updateClock, 1000);

