/**
 * PDF Export helper functions for ACER Reserve Needs Report
 * This file contains additional functionality for PDF generation
 */

// Custom renderer function to ensure charts render correctly in PDFs
function renderChartsForPdf() {
    // Make sure all elements are fully rendered
    document.querySelectorAll('.chartBar').forEach(bar => {
        // Force render with explicit dimensions
        const computedStyle = getComputedStyle(bar);
        bar.style.width = computedStyle.width;
        bar.style.height = computedStyle.height;
        bar.style.backgroundColor = computedStyle.backgroundColor;

        // Ensure chart labels are visible
        const label = bar.querySelector('.chartLabel');
        const value = bar.querySelector('.chartValue');
        if (label) label.style.visibility = 'visible';
        if (value) value.style.visibility = 'visible';
    });
}

// Enhanced PDF generation with proper fonts
function enhancePdfGeneration(pdf, option) {
    // Add custom font handling if needed
    pdf.internal.events.subscribe('addFont', function (data) {
        // Font processing logic if needed
    });

    // Add page numbers
    const pageCount = pdf.internal.getNumberOfPages();
    for (let i = 1; i <= pageCount; i++) {
        pdf.setPage(i);
        pdf.setFontSize(8);
        pdf.setTextColor(100);
        pdf.text('Page ' + i + ' of ' + pageCount, pdf.internal.pageSize.getWidth() - 25,
            pdf.internal.pageSize.getHeight() - 10);
    }
}

// Fix known HTML2PDF issues with complex tables
function fixTableRendering() {
    // Temporarily adjust table structure to work better with html2pdf
    document.querySelectorAll('.reserveNeedTable').forEach(table => {
        // Set explicit width on all cells for better rendering
        table.querySelectorAll('th, td').forEach(cell => {
            cell.style.width = (100 / cell.parentElement.children.length) + '%';
        });
    });
}
