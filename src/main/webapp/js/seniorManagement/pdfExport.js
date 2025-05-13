/**
 * PDF Export helper functions for ACER Reserve Needs Report
 * This file contains additional functionality for PDF generation
 */

function renderChartsForPdf() {
    document.querySelectorAll('.chartBar').forEach(bar => {
        const computedStyle = getComputedStyle(bar);
        bar.style.width = computedStyle.width;
        bar.style.height = computedStyle.height;
        bar.style.backgroundColor = computedStyle.backgroundColor;

        const label = bar.querySelector('.chartLabel');
        const value = bar.querySelector('.chartValue');
        if (label) label.style.visibility = 'visible';
        if (value) value.style.visibility = 'visible';
    });
}

function enhancePdfGeneration(pdf, option) {
    pdf.internal.events.subscribe('addFont', function (data) {
    });

    const pageCount = pdf.internal.getNumberOfPages();
    for (let i = 1; i <= pageCount; i++) {
        pdf.setPage(i);
        pdf.setFontSize(8);
        pdf.setTextColor(100);
        pdf.text('Page ' + i + ' of ' + pageCount, pdf.internal.pageSize.getWidth() - 25,
            pdf.internal.pageSize.getHeight() - 10);
    }
}

function fixTableRendering() {
    document.querySelectorAll('.reserveNeedTable').forEach(table => {
        table.querySelectorAll('th, td').forEach(cell => {
            cell.style.width = (100 / cell.parentElement.children.length) + '%';
        });
    });
}
