/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

$(document).ready(function () {
    updateFruitCount();

    $("#fruitSearch").on("keyup", filterFruits);
    $("#typeFilter").on("change", filterFruits);

    $("#editModeToggle").on("click", function () {
        enterEditMode();
    });

    $("#cancelEditBtn").on("click", function () {
        exitEditMode(true);
        $(this).addClass("d-none");
    });

    $(document).on("click", ".incrementBtn", function () {
        const input = $(this).siblings(".stockInput");
        const currentValue = parseInt(input.val()) || 0;
        input.val(currentValue + 1);
        updateInputState(input);
    });

    $(document).on("click", ".decrementBtn", function () {
        const input = $(this).siblings(".stockInput");
        const currentValue = parseInt(input.val()) || 0;
        if (currentValue > 0) {
            input.val(currentValue - 1);
            updateInputState(input);
        }
    });

    $(document).on("change", ".stockInput", function () {
        updateInputState($(this));
    });

    function enterEditMode() {
        $(".stockReadMode").addClass("d-none");
        $(".stockEditMode").removeClass("d-none");
        $("#editModeToggle").addClass("d-none");
        $("#actionButtons").css("display", "flex !important").show();
        $("#modifiedItemsRow").removeClass("d-none");
        $("#cancelEditBtn").removeClass("d-none");

        updateModifiedCount();
    }

    function exitEditMode(reset) {
        if (reset) {
            resetForm();
        }

        if (!reset) {
            $(".stockInput").each(function () {
                const newValue = $(this).val();
                $(this).closest("td").find(".stockValue").text(newValue);
            });
        }

        $(".stockReadMode").removeClass("d-none");
        $(".stockEditMode").addClass("d-none");
        $("#editModeToggle").removeClass("d-none");
        $("#actionButtons").hide();
        $("#modifiedItemsRow").addClass("d-none");
    }

    function filterFruits() {
        let searchText = $('#fruitSearch').val().toLowerCase();
        let type = $('#typeFilter').val().toLowerCase();

        $('.fruitItem').each(function () {
            let fruitName = $(this).data('fruit-name').toLowerCase();
            let fruitType = $(this).data('type').toLowerCase();

            let matchesSearch = fruitName.includes(searchText);
            let matchesType = type === 'all' || fruitType === type;

            if (matchesSearch && matchesType) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });

        updateFruitCount();
    }

    function updateFruitCount() {
        let totalFruits = $('.fruitItem').length;
        let visibleFruits = $('.fruitItem:visible').length;

        $('#totalFruitCount').text(totalFruits);
        $('#visibleFruitCount').text(visibleFruits);
        $('#totalItems').text(totalFruits);

        if (visibleFruits < totalFruits) {
            $('.fruitResultInfo').removeClass('d-none');
        } else {
            $('.fruitResultInfo').addClass('d-none');
        }
    }

    function updateInputState(input) {
        const originalValue = input.data('original').toString();
        const currentValue = input.val();

        if (currentValue !== originalValue) {
            input.addClass('modifiedValue');
        } else {
            input.removeClass('modifiedValue');
        }

        updateModifiedCount();
    }

    function updateModifiedCount() {
        const modifiedCount = $('.modifiedValue').length;
        $('#modifiedItems').text(modifiedCount);
    }

    function resetForm() {
        $('.stockInput').each(function () {
            $(this).val($(this).data('original'));
            $(this).removeClass('modifiedValue');
        });

        updateModifiedCount();
    }

    $("#countryFilter").on("change", function () {
        filterFruits();
    });

    $("#resetFilters").on("click", function () {
        $("#fruitSearch").val("");
        $("#typeFilter").val("all");
        $("#countryFilter").val("all");
        filterFruits();
    });

    function filterFruits() {
        var searchTerm = $("#fruitSearch").val().toLowerCase();
        var typeFilter = $("#typeFilter").val();
        var countryFilter = $("#countryFilter").val();

        var visibleCount = 0;
        var totalCount = 0;

        $(".fruitItem").each(function () {
            totalCount++;

            var fruitName = $(this).data("fruit-name").toLowerCase();
            var fruitType = $(this).data("type").toLowerCase();
            var fruitCountry = $(this).find("small.text-muted").text().split(", ")[1] || "";

            var matchesSearch = fruitName.indexOf(searchTerm) > -1;
            var matchesType = typeFilter === "all" || fruitType === typeFilter.toLowerCase();
            var matchesCountry = countryFilter === "all" || fruitCountry.indexOf(countryFilter) > -1;

            if (matchesSearch && matchesType && matchesCountry) {
                $(this).show();
                visibleCount++;
            } else {
                $(this).hide();
            }
        });

        $("#visibleFruitCount").text(visibleCount);
        $("#totalFruitCount").text(totalCount);

        if (visibleCount < totalCount) {
            $(".fruitResultInfo").removeClass("d-none");
        } else {
            $(".fruitResultInfo").addClass("d-none");
        }
    }
});


