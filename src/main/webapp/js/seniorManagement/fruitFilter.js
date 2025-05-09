/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

document.addEventListener('DOMContentLoaded', function () {
    const fruitSearch = document.getElementById('fruitSearch');
    const typeFilter = document.getElementById('typeFilter');
    const countryFilter = document.getElementById('countryFilter');
    const resetFilters = document.getElementById('resetFilters');
    const fruitRows = document.querySelectorAll('.fruitItem');
    const visibleFruitCount = document.getElementById('visibleFruitCount');
    const totalFruitCount = document.getElementById('totalFruitCount');
    const fruitResultInfo = document.querySelector('.fruitResultInfo');

    totalFruitCount.textContent = fruitRows.length;

    function filterFruits() {
        let visibleCount = 0;
        const searchText = fruitSearch.value.trim().toLowerCase();
        const selectedType = typeFilter.value;
        const selectedCountry = countryFilter.value;

        fruitRows.forEach(row => {
            const fruitName = row.dataset.fruitName.toLowerCase();
            const fruitType = row.dataset.type;
            const fruitCountry = row.querySelector('small').textContent.split(', ')[1].toLowerCase(); // Extract country from "City, Country"

            // Check if row matches all filters
            const matchesSearch = fruitName.includes(searchText);
            const matchesType = selectedType === 'all' || fruitType === selectedType;
            const matchesCountry = selectedCountry === 'all' || fruitCountry.toLowerCase() === selectedCountry.toLowerCase();

            // Show or hide row
            if (matchesSearch && matchesType && matchesCountry) {
                row.style.display = '';
                visibleCount++;
            } else {
                row.style.display = 'none';
            }
        });

        // Update result info
        visibleFruitCount.textContent = visibleCount;
        fruitResultInfo.classList.toggle('d-none', visibleCount === fruitRows.length && !searchText && selectedType === 'all' && selectedCountry === 'all');
    }

    // Event listeners for filters
    fruitSearch.addEventListener('input', filterFruits);
    typeFilter.addEventListener('change', filterFruits);
    countryFilter.addEventListener('change', filterFruits);

    // Reset filters
    resetFilters.addEventListener('click', () => {
        fruitSearch.value = '';
        typeFilter.value = 'all';
        countryFilter.value = 'all';
        filterFruits();
    });

    filterFruits();
});
