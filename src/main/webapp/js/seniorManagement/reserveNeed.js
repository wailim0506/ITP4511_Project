/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

$(document).ready(function () {

    $('.cityFilterContainer').hide();

    function updateFilterVisibility() {
        var viewLevel = $('#viewLevel').val();
        if (viewLevel === 'city') {
            $('.cityFilterContainer').show();
            $('#countryFilterContainer').hide();
            $('.shopFilterContainer').hide();
        } else if (viewLevel === 'c') {
            $('.cityFilterContainer').hide();
            $('#countryFilterContainer').show();
            $('.shopFilterContainer').hide();
        } else {
            $('.cityFilterContainer').hide();
            $('#countryFilterContainer').hide();
            $('.shopFilterContainer').show();
        }
    }

    updateFilterVisibility();

    $('#filterButtonContainer').on('click', function () {
        window.location.href = '/ITP4511_Project/reserveNeed?viewLevel=c&cn=all&date=last12Months';
    });

    // Dynamically update UI when view level changes
    $('#viewLevel').on('change', function () {
        updateFilterVisibility();
        var viewLevel = $(this).val();
        var country = $('#countryFilter').val();
        var city = $('#cityFilter').val();
        var shop = $('#shopFilter').val();
        var dateRange = $('#dateRangeFilter').val();
        var url = '';
        if (viewLevel === 'c') {
            url = `/ITP4511_Project/reserveNeed?viewLevel=${viewLevel}&cn=${country}&date=${dateRange}`;
        }
        else if (viewLevel === 'city') {
            url = `/ITP4511_Project/reserveNeed?viewLevel=${viewLevel}&city=${city}&date=${dateRange}`;
        } else {
            url = `/ITP4511_Project/reserveNeed?viewLevel=shop&shop=${shop}&date=${dateRange}`;
        }
        window.location.href = url;
    });

    // Show/hide custom date range based on selection
    $('#dateRangeFilter').on('change', function () {
        var viewLevel = $('#viewLevel').val();
        var country = $('#countryFilter').val();
        var city = $('#cityFilter').val();
        var shop = $('#shopFilter').val();
        var dateRange = $(this).val();
        var url = '';
        if (viewLevel === 'c') {
            url = `/ITP4511_Project/reserveNeed?viewLevel=${viewLevel}&cn=${country}&date=${dateRange}`;
        }
        else if (viewLevel === 'city') {
            url = `/ITP4511_Project/reserveNeed?viewLevel=${viewLevel}&city=${city}&date=${dateRange}`;
        } else {
            url = `/ITP4511_Project/reserveNeed?viewLevel=shop&shop=${shop}&date=${dateRange}`;
        }

        window.location.href = url;
    });

    $('#cityFilter').on('change', function () {
        var viewLevel = $('#viewLevel').val();
        var city = $(this).val();
        var dateRange = $('#dateRangeFilter').val();
        var url = '';
        if (viewLevel === 'c') {
            url = `/ITP4511_Project/reserveNeed?viewLevel=${viewLevel}&cn=${country}&date=${dateRange}`;
        }
        else if (viewLevel === 'city') {
            url = `/ITP4511_Project/reserveNeed?viewLevel=${viewLevel}&city=${city}&date=${dateRange}`;
        } else {
            //url = `/ITP4511_Project/reserveNeed?viewLevel=${viewLevel}&cn=${country}&date=${dateRange}`;
        }

        window.location.href = url;
    });

    // Handle country filter changes - would update city dropdown options in real implementation
    $('#countryFilter').on('change', function () {
        var viewLevel = $('#viewLevel').val();
        var country = $(this).val();
        var dateRange = $('#dateRangeFilter').val();

        url = `/ITP4511_Project/reserveNeed?viewLevel=${viewLevel}&cn=${country}&date=${dateRange}`;
        window.location.href = url;
    });

    $('#shopFilter').on('change', function () {
        var viewLevel = $('#viewLevel').val();
        var shop = $(this).val();
        var dateRange = $('#dateRangeFilter').val();
        var url = '';
        if (viewLevel === 'c') {
            url = `/ITP4511_Project/reserveNeed?viewLevel=${viewLevel}&cn=${country}&date=${dateRange}`;
        }
        else if (viewLevel === 'city') {
            url = `/ITP4511_Project/reserveNeed?viewLevel=${viewLevel}&city=${city}&date=${dateRange}`;
        } else {
            url = `/ITP4511_Project/reserveNeed?viewLevel=shop&shop=${shop}&date=${dateRange}`;
        }

        window.location.href = url;
    });

    // Print report button functionality - completely revised
    $('#printReportBtn').on('click', function () {
        // Create a new window for better print control
        let printWindow = window.open('', '_blank');

        // Get current view information
        const viewLevel = $('#viewLevel').val();
        let viewTitle = "Reservation Needs by Country/Region";
        if (viewLevel === 'city') viewTitle = "Reservation Needs by City";
        if (viewLevel === 'shop') viewTitle = "Reservation Needs by Shop";

        // Get date range text
        const dateRange = $('#dateRangeFilter option:selected').text();

        // Prepare print content with styling
        let printContent = `
            <!DOCTYPE html>
            <html>
            <head>
                <title>ACER Reserve Needs Report</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
                <style>
                    body {
                        font-family: Arial, sans-serif;
                        padding: 20px;
                    }
                    .report-header {
                        text-align: center;
                        margin-bottom: 30px;
                        padding-bottom: 20px;
                        border-bottom: 2px solid #ddd;
                    }
                    .company-name {
                        font-size: 24px;
                        font-weight: bold;
                        color: #0d6efd;
                        margin-bottom: 5px;
                    }
                    .report-title {
                        font-size: 20px;
                        margin-bottom: 5px;
                    }
                    .report-subtitle {
                        font-size: 14px;
                        color: #666;
                    }
                    .summary-section {
                        display: flex;
                        justify-content: space-between;
                        margin-bottom: 30px;
                    }
                    .summary-card {
                        border: 1px solid #ddd;
                        border-radius: 5px;
                        padding: 15px;
                        width: 48%;
                    }
                    .summary-title {
                        font-size: 14px;
                        color: #666;
                    }
                    .summary-value {
                        font-size: 24px;
                        font-weight: bold;
                    }
                    .data-table {
                        width: 100%;
                        border-collapse: collapse;
                        margin-bottom: 30px;
                    }
                    .data-table th {
                        background-color: #f5f5f5;
                        padding: 10px;
                        text-align: left;
                        border-bottom: 2px solid #ddd;
                    }
                    .data-table td {
                        padding: 10px;
                        border-bottom: 1px solid #ddd;
                    }
                    .chart-section {
                        margin-top: 30px;
                        page-break-inside: avoid;
                    }
                    .chart-title {
                        font-size: 18px;
                        margin-bottom: 15px;
                    }
                    .chart-container {
                        display: flex;
                        justify-content: space-around;
                        height: 250px;
                        align-items: flex-end;
                    }
                    .chart-bar {
                        position: relative;
                        display: flex;
                        flex-direction: column;
                        justify-content: flex-end;
                        align-items: center;
                        border-radius: 4px 4px 0 0;
                        margin: 0 10px;
                        text-align: center;
                    }
                    .chart-label {
                        margin-top: 5px;
                        font-weight: bold;
                    }
                    .chart-value {
                        position: absolute;
                        top: -25px;
                        font-weight: bold;
                    }
                    .page-footer {
                        margin-top: 30px;
                        text-align: center;
                        font-size: 12px;
                        color: #666;
                        border-top: 1px solid #ddd;
                        padding-top: 10px;
                    }
                    @page {
                        size: A4;
                        margin: 1cm;
                    }
                </style>
            </head>
            <body>
                <div class="report-header">
                    <div class="company-name">ACER Fruit Company</div>
                    <div class="report-title">${viewTitle}</div>
                    <div class="report-subtitle">Generated on ${new Date().toLocaleDateString()} • Data period: ${dateRange}</div>
                </div>
                
                <div class="summary-section">
                    <div class="summary-card">
                        <div class="summary-title">All Time Total Reservations</div>
                        <div class="summary-value">${$('#total').text() || '${total}'}</div>
                    </div>
                    <div class="summary-card">
                        <div class="summary-title">All Time Total Fruit Items</div>
                        <div class="summary-value">${$('#totalFruit').text() || '${totalFruit}'}</div>
                    </div>
                </div>
                
                <div class="table-section">
                    <h3>${viewTitle}</h3>`;

        // Add the appropriate table based on current view
        if (viewLevel === 'c') {
            printContent += $('#countryView').parent().html();
        } else if (viewLevel === 'city') {
            printContent += $('#cityView').parent().html();
        } else if (viewLevel === 'shop') {
            printContent += $('#shopView').parent().html();
        }

        // Add chart section
        printContent += `
                </div>
                
                <div class="chart-section">
                    <h3 class="chart-title">Top Requested Fruits</h3>
                    <div class="chart-container">`;

        // Clone the chart bars
        $('.chartBar').each(function () {
            const style = $(this).attr('style');
            const label = $(this).find('.chartLabel').text();
            const value = $(this).find('.chartValue').text();

            printContent += `
                <div class="chart-bar" style="${style}">
                    <span class="chart-value">${value}</span>
                    <span class="chart-label">${label}</span>
                </div>`;
        });

        // Close the HTML structure
        printContent += `
                    </div>
                </div>
                
                <div class="page-footer">
                    ACER Reserve Needs Analysis Report • Generated by Senior Management System
                </div>
            </body>
            </html>
        `;

        // Write to the new window and print
        printWindow.document.write(printContent);
        printWindow.document.close();

        // Wait for resources to load then print
        printWindow.onload = function () {
            setTimeout(function () {
                printWindow.print();
                // Some browsers may close the window after printing, some may not
            }, 500);
        };
    });

    // Export to PDF button functionality - completely revised
    $('#exportPdfBtn').on('click', function () {
        // Show loading indicator
        const loadingElement = $('<div class="position-fixed top-0 start-0 w-100 h-100 d-flex justify-content-center align-items-center bg-light bg-opacity-75" style="z-index:9999">' +
            '<div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div>' +
            '<span class="ms-2">Generating PDF...</span></div>');
        $('body').append(loadingElement);

        // Get current view information
        const viewLevel = $('#viewLevel').val();
        let viewTitle = "Reservation Needs by Country/Region";
        if (viewLevel === 'city') viewTitle = "Reservation Needs by City";
        if (viewLevel === 'shop') viewTitle = "Reservation Needs by Shop";

        // Get date range text
        const dateRange = $('#dateRangeFilter option:selected').text();

        // Create a dedicated container for PDF output
        const pdfContainer = document.createElement('div');
        pdfContainer.innerHTML = `
            <div class="pdf-container" style="width:210mm; padding:10mm; font-family:Arial, sans-serif;">
                <div style="text-align:center; margin-bottom:20px;">
                    <h1 style="color:#0d6efd; margin-bottom:5px;">ACER Fruit Company</h1>
                    <h2 style="margin-bottom:5px;">${viewTitle}</h2>
                    <p style="color:#666;">Generated on ${new Date().toLocaleDateString()} • Data period: ${dateRange}</p>
                </div>
                
                <div style="display:flex; justify-content:space-between; margin-bottom:20px;">
                    <div style="border:1px solid #ddd; border-radius:5px; padding:15px; width:48%;">
                        <p style="font-size:14px; color:#666; margin-bottom:5px;">All Time Total Reservations</p>
                        <p style="font-size:24px; font-weight:bold; margin:0;">${$('#total').text() || $('h3:contains("All Time Total Reservations")').next().text()}</p>
                    </div>
                    <div style="border:1px solid #ddd; border-radius:5px; padding:15px; width:48%;">
                        <p style="font-size:14px; color:#666; margin-bottom:5px;">All Time Total Fruit Items</p>
                        <p style="font-size:24px; font-weight:bold; margin:0;">${$('#totalFruit').text() || $('h3:contains("All Time Total Fruit Items")').next().text()}</p>
                    </div>
                </div>
                
                <div style="margin-bottom:20px;">
                    <h3 style="margin-bottom:10px;">${viewTitle}</h3>
                    <div class="table-wrapper"></div>
                </div>
                
                <div style="margin-top:20px; page-break-inside:avoid;">
                    <h3 style="margin-bottom:10px;">Top Requested Fruits</h3>
                    <div class="chart-wrapper" style="height:250px; display:flex; justify-content:space-around; align-items:flex-end;"></div>
                </div>
                
                <div style="margin-top:30px; text-align:center; font-size:12px; color:#666; border-top:1px solid #ddd; padding-top:10px;">
                    ACER Reserve Needs Analysis Report • Generated by Senior Management System
                </div>
            </div>
        `;

        // Clone the appropriate table
        let tableHtml = '';
        if (viewLevel === 'c') {
            tableHtml = $('#countryView').clone();
        } else if (viewLevel === 'city') {
            tableHtml = $('#cityView').clone();
        } else if (viewLevel === 'shop') {
            tableHtml = $('#shopView').clone();
        }

        // Style the table for PDF
        tableHtml.find('th').css({
            'background-color': '#f5f5f5',
            'padding': '8px',
            'border-bottom': '2px solid #ddd',
            'text-align': 'left'
        });

        tableHtml.find('td').css({
            'padding': '8px',
            'border-bottom': '1px solid #ddd'
        });

        tableHtml.css({
            'width': '100%',
            'border-collapse': 'collapse',
            'font-size': '11px'
        });

        // Make the table visible for PDF export
        tableHtml.removeClass('d-none');

        // Add table to container
        pdfContainer.querySelector('.table-wrapper').appendChild(tableHtml[0]);

        // Clone and add chart bars
        $('.chartBar').each(function () {
            const barClone = $(this).clone();
            const label = $(this).find('.chartLabel').text();
            const value = $(this).find('.chartValue').text();
            const color = $(this).css('background-color');
            const height = $(this).css('height');

            const chartBarDiv = document.createElement('div');
            chartBarDiv.style.cssText = `
                position: relative;
                display: flex;
                flex-direction: column;
                justify-content: flex-end;
                align-items: center;
                background-color: ${color};
                height: ${height};
                width: 60px;
                border-radius: 4px 4px 0 0;
            `;

            const valuePara = document.createElement('p');
            valuePara.style.cssText = 'position: absolute; top: -25px; font-weight: bold; margin: 0;';
            valuePara.innerText = value;

            const labelPara = document.createElement('p');
            labelPara.style.cssText = 'margin-top: 5px; font-weight: bold; text-align: center;';
            labelPara.innerText = label;

            chartBarDiv.appendChild(valuePara);
            chartBarDiv.appendChild(document.createTextNode('\u00A0')); // Non-breaking space

            pdfContainer.querySelector('.chart-wrapper').appendChild(chartBarDiv);
            $(chartBarDiv).after(labelPara);
        });

        // Generate filename based on current date
        const now = new Date();
        const filename = `ACER_ReserveNeeds_Report_${now.getFullYear()}${(now.getMonth() + 1).toString().padStart(2, '0')}${now.getDate().toString().padStart(2, '0')}.pdf`;

        // Define PDF options
        const options = {
            margin: [10, 10],
            filename: filename,
            image: { type: 'jpeg', quality: 1.0 },
            html2canvas: {
                scale: 2,
                useCORS: true,
                logging: true
            },
            jsPDF: {
                unit: 'mm',
                format: 'a4',
                orientation: 'portrait',
                putOnlyUsedFonts: true
            }
        };

        // Generate and download PDF
        html2pdf().from(pdfContainer).set(options).save()
            .then(() => {
                // Remove loading indicator when done
                loadingElement.remove();
            })
            .catch((error) => {
                console.error('PDF generation failed:', error);
                loadingElement.remove();
                alert('PDF generation failed. Please try again.');
            });
    });

    // AI Analysis button functionality
    $('#aiAnalysisBtn').on('click', function () {
        // Open the modal
        const analysisModal = new bootstrap.Modal(document.getElementById('aiAnalysisModal'));
        analysisModal.show();

        // Reset modal state
        $('#aiAnalysisLoading').removeClass('d-none');
        $('#aiAnalysisContent').addClass('d-none');
        $('#aiAnalysisError').addClass('d-none');
        $('#downloadAnalysisBtn').addClass('d-none');

        // Get current view and date range
        const viewLevel = $('#viewLevel').val();
        let viewTitle = "Country/Region";
        if (viewLevel === 'city') viewTitle = "City";
        if (viewLevel === 'shop') viewTitle = "Shop";

        const dateRange = $('#dateRangeFilter option:selected').text();
        const totalReservations = $('#total').text();
        const totalFruitItems = $('#totalFruit').text();

        // Extract data from the currently visible table
        let tableData = [];
        let visibleTable;

        if (viewLevel === 'c') {
            visibleTable = $('#countryView');
        } else if (viewLevel === 'city') {
            visibleTable = $('#cityView');
        } else {
            visibleTable = $('#shopView');
        }

        // Extract table headers
        let headers = [];
        visibleTable.find('thead th').each(function () {
            headers.push($(this).text().trim());
        });

        // Extract table rows
        visibleTable.find('tbody tr').each(function () {
            let rowData = {};
            let cells = $(this).find('td');

            for (let i = 0; i < cells.length; i++) {
                // For cells with rowspan, we need to check if they exist
                let headerIndex = Math.min(i, headers.length - 1);
                let value = $(cells[i]).text().trim();

                // Handle cells with rowspan (they might be empty in subsequent rows)
                if (value) {
                    rowData[headers[headerIndex]] = value;
                }
            }

            tableData.push(rowData);
        });

        // Prepare the prompt for the AI
        const prompt = `
            You are a data analyst for ACER Fruit Company. Please analyze the following fruit reservation data and provide business insights.

            VIEW LEVEL: ${viewTitle}
            DATE RANGE: ${dateRange}
            TABLE DATA:
            ${JSON.stringify(tableData, null, 2)}

            Please provide a comprehensive analysis with EXACTLY these three sections clearly marked:
            
            DATA SUMMARY: Summarize the key data points (2-3 sentences)
            
            KEY INSIGHTS: Identify 3-5 important patterns or trends
            
            RECOMMENDATIONS: Provide 2-3 actionable business recommendations based on the data
            
            Keep each section clearly separated and labeled. Do not include any other sections or headings. Do not format in markdown.Do not use *.
            `;

        // Send request to the DeepSeek API
        const requestBody = {
            model: 'deepseek-chat',
            messages: [
                { role: 'system', content: 'You are a professional data analyst for ACER Fruit Company.' },
                { role: 'user', content: prompt }
            ],
            temperature: 1.0,
            max_tokens: 1500,
            stream: false
        };

        fetch('https://api.deepseek.com/chat/completions', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer sk-ccbb933fbf0e4d38830a52819ff9c761`
            },
            body: JSON.stringify(requestBody)
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error(`API error: ${response.status} ${response.statusText}`);
                }
                return response.json();
            })
            .then(data => {
                // Hide loading state
                $('#aiAnalysisLoading').addClass('d-none');

                if (data.error) {
                    // Show error message
                    $('#aiAnalysisError').removeClass('d-none');
                    $('#aiErrorMessage').text(`Error: ${data.error.message}`);
                } else if (data.choices && data.choices[0] && data.choices[0].message) {
                    // Parse and display AI response
                    const response = data.choices[0].message.content;

                    // Process the response to extract the three sections
                    const parsedResponse = parseAIResponse(response);

                    $('#aiDataSummary').html(parsedResponse.summary);
                    $('#aiKeyInsights').html(parsedResponse.insights);
                    $('#aiRecommendations').html(parsedResponse.recommendations);

                    // Show the content and download button
                    $('#aiAnalysisContent').removeClass('d-none');
                    $('#downloadAnalysisBtn').removeClass('d-none');

                    // Store the full response for download
                    $('#downloadAnalysisBtn').data('analysis', response);
                } else {
                    // Handle unexpected response
                    $('#aiAnalysisError').removeClass('d-none');
                    $('#aiErrorMessage').text('Unexpected API response format.');
                }
            })
            .catch(error => {
                // Hide loading, show error
                $('#aiAnalysisLoading').addClass('d-none');
                $('#aiAnalysisError').removeClass('d-none');
                $('#aiErrorMessage').text(`Error: ${error.message}`);
            });
    });

    // Handle download analysis button
    $('#downloadAnalysisBtn').on('click', function () {
        const analysis = $(this).data('analysis');

        if (analysis) {
            const viewLevel = $('#viewLevel').val();
            let viewTitle = "Country_Region";
            if (viewLevel === 'city') viewTitle = "City";
            if (viewLevel === 'shop') viewTitle = "Shop";

            const dateRange = $('#dateRangeFilter option:selected').text().replace(/\s+/g, '_');
            const filename = `ACER_AI_Analysis_${viewTitle}_${dateRange}_${new Date().toISOString().slice(0, 10)}.txt`;

            // Create and trigger download
            const blob = new Blob([analysis], { type: 'text/plain' });
            const link = document.createElement('a');
            link.href = window.URL.createObjectURL(blob);
            link.download = filename;
            link.click();
        }
    });

    // Helper function to parse AI response into sections
    function parseAIResponse(response) {
        // Default result structure
        const result = {
            summary: '',
            insights: '',
            recommendations: ''
        };

        try {
            // Look for data summary section with improved regex patterns
            const summaryMatch = response.match(/(?:DATA SUMMARY|Data Summary|1\.\s*Data Summary):(.*?)(?=(?:KEY INSIGHTS|Key Insights|2\.\s*Key Insights))/si);
            if (summaryMatch && summaryMatch[1]) {
                result.summary = formatSection(summaryMatch[1]);
            }

            // Look for key insights section with improved regex patterns
            const insightsMatch = response.match(/(?:KEY INSIGHTS|Key Insights|2\.\s*Key Insights):(.*?)(?=(?:RECOMMENDATIONS|Recommendations|3\.\s*Recommendations))/si);
            if (insightsMatch && insightsMatch[1]) {
                result.insights = formatSection(insightsMatch[1]);
            }

            // Look for recommendations section with improved regex patterns
            const recommendationsMatch = response.match(/(?:RECOMMENDATIONS|Recommendations|3\.\s*Recommendations):(.*?)(?=$)/si);
            if (recommendationsMatch && recommendationsMatch[1]) {
                result.recommendations = formatSection(recommendationsMatch[1]);
            }

            // Fallback for numbered sections with no colon
            if (!result.summary) {
                const altSummaryMatch = response.match(/(?:1\.\s*Data Summary\s*)(.*?)(?=(?:2\.\s*Key Insights))/si);
                if (altSummaryMatch && altSummaryMatch[1]) {
                    result.summary = formatSection(altSummaryMatch[1]);
                }
            }

            if (!result.insights) {
                const altInsightsMatch = response.match(/(?:2\.\s*Key Insights\s*)(.*?)(?=(?:3\.\s*Recommendations))/si);
                if (altInsightsMatch && altInsightsMatch[1]) {
                    result.insights = formatSection(altInsightsMatch[1]);
                }
            }

            if (!result.recommendations) {
                const altRecommendationsMatch = response.match(/(?:3\.\s*Recommendations\s*)(.*?)(?=$)/si);
                if (altRecommendationsMatch && altRecommendationsMatch[1]) {
                    result.recommendations = formatSection(altRecommendationsMatch[1]);
                }
            }

            // If we couldn't parse structured sections, try to intelligently divide the content
            if (!result.summary && !result.insights && !result.recommendations) {
                console.log("Falling back to content division");
                const paragraphs = response.split(/\n\n+/).filter(p => p.trim());

                if (paragraphs.length >= 3) {
                    // If we have at least 3 paragraphs, distribute them
                    result.summary = formatSection(paragraphs[0]);

                    // Middle paragraphs go to insights
                    const middleParagraphs = paragraphs.slice(1, paragraphs.length - 1).join("\n\n");
                    result.insights = formatSection(middleParagraphs);

                    // Last paragraph goes to recommendations
                    result.recommendations = formatSection(paragraphs[paragraphs.length - 1]);
                } else {
                    // Not enough paragraphs, put everything in summary
                    result.summary = formatSection(response);
                }
            }
        } catch (error) {
            console.error("Error parsing AI response:", error);
            // Fallback to returning the raw response with basic formatting
            result.summary = `<p>${response.replace(/\n/g, '<br>')}</p>`;
        }

        return result;
    }

    // Helper function to format a section of text with proper HTML
    function formatSection(text) {
        if (!text) return '';

        // Clean up the text
        text = text.trim();

        // Check for bullet points or numbered lists
        const hasBullets = text.match(/^[-*•]\s+/m);
        const hasNumbers = text.match(/^\d+\.\s+/m);

        if (hasNumbers || hasBullets) {
            const items = text.split(/\n+/).filter(item => item.trim());
            const listItems = [];
            let inList = false;
            let currentList = '';
            let listType = hasNumbers ? 'ol' : 'ul';

            for (let item of items) {
                item = item.trim();
                const itemMatch = item.match(/^([-*•]|\d+\.)\s+(.*)/);

                if (itemMatch) {
                    // This is a list item
                    if (!inList) {
                        inList = true;
                        currentList = `<${listType}>`;
                    }
                    currentList += `<li>${itemMatch[2]}</li>`;
                } else {
                    // Not a list item
                    if (inList) {
                        inList = false;
                        currentList += `</${listType}>`;
                        listItems.push(currentList);
                        currentList = '';
                    }
                    listItems.push(`<p>${item}</p>`);
                }
            }

            // Close any open list
            if (inList) {
                currentList += `</${listType}>`;
                listItems.push(currentList);
            }

            return listItems.join('');
        }

        // Default handling: convert line breaks to <p> tags
        return text.split(/\n\n+/).map(para => `<p>${para.replace(/\n/g, ' ')}</p>`).join('');
    }
});




