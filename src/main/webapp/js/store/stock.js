/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

$(document).ready(function () {
    // Initialize the page
    updateFruitCount();

    // Search and filter controls
    $("#fruitSearch").on("keyup", filterFruits);
    $("#typeFilter").on("change", filterFruits);

    // Toggle Edit Mode
    $("#editModeToggle").on("click", function () {
        enterEditMode();
    });

    // Cancel Edit
    $("#cancelEditBtn").on("click", function () {
        exitEditMode(true);
    });

    // Save Changes
    $("#saveChangesBtn").on("click", function () {
        saveChanges();
    });

    // Increment button click handler
    $(document).on("click", ".incrementBtn", function () {
        const input = $(this).siblings(".stockInput");
        const currentValue = parseInt(input.val()) || 0;
        input.val(currentValue + 1);
        updateInputState(input);
    });

    // Decrement button click handler
    $(document).on("click", ".decrementBtn", function () {
        const input = $(this).siblings(".stockInput");
        const currentValue = parseInt(input.val()) || 0;
        if (currentValue > 0) {
            input.val(currentValue - 1);
            updateInputState(input);
        }
    });

    // Direct input change handler
    $(document).on("change", ".stockInput", function () {
        updateInputState($(this));
    });

    // Function to enter edit mode
    function enterEditMode() {
        // Switch visibility
        $(".stockReadMode").addClass("d-none");
        $(".stockEditMode").removeClass("d-none");
        $("#editModeToggle").addClass("d-none");
        $("#actionButtons").css("display", "flex !important").show();
        $("#modifiedItemsRow").removeClass("d-none");

        // Reset modified count
        updateModifiedCount();
    }

    // Function to exit edit mode
    function exitEditMode(reset) {
        if (reset) {
            // Reset all inputs to their original values
            resetForm();
        }

        // Update read mode values with current input values if not reset
        if (!reset) {
            $(".stockInput").each(function () {
                const newValue = $(this).val();
                $(this).closest("td").find(".stockValue").text(newValue);
            });
        }

        // Switch visibility
        $(".stockReadMode").removeClass("d-none");
        $(".stockEditMode").addClass("d-none");
        $("#editModeToggle").removeClass("d-none");
        $("#actionButtons").hide();
        $("#modifiedItemsRow").addClass("d-none");
    }

    // Function to save changes
    function saveChanges() {
        const modifiedCount = $('.modifiedValue').length;

        if (modifiedCount > 0) {
            // Create hidden inputs for the form
            $("#stockForm").empty().append('<input type="hidden" name="action" value="update">');

            $(".stockInput").each(function () {
                const name = $(this).attr("name");
                const value = $(this).val();

                // Only include modified values
                if (value !== $(this).data("original").toString()) {
                    $("#stockForm").append(`<input type="hidden" name="${name}" value="${value}">`);
                }
            });

            if (confirm('Are you sure you want to save these inventory changes?')) {
                $("#stockForm").submit();
            }
        } else {
            alert('No changes have been made to the inventory.');
            exitEditMode(true);
        }
    }

    // Function to filter fruits based on search text and type
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

    // Update fruit count for search results
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

    // Update the visual state of the input based on if it's changed
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

    // Update count of modified items in the summary
    function updateModifiedCount() {
        const modifiedCount = $('.modifiedValue').length;
        $('#modifiedItems').text(modifiedCount);
    }

    // Reset the form to original values
    function resetForm() {
        $('.stockInput').each(function () {
            $(this).val($(this).data('original'));
            $(this).removeClass('modifiedValue');
        });

        updateModifiedCount();
    }
});


