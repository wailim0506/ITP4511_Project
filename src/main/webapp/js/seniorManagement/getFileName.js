/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
document.addEventListener('DOMContentLoaded', function () {
    const fileInput = document.getElementById('formFile');
    const hiddenInput = document.createElement('input');
    hiddenInput.type = 'hidden';
    hiddenInput.name = 'filename';
    document.querySelector('.mb-3').appendChild(hiddenInput);

    fileInput.addEventListener('change', function(event) {
        const file = event.target.files[0];
        const previewBox = document.getElementById('previewBox');
        const imagePreview = document.getElementById('imagePreview');
        const noImageText = document.getElementById('noImageText');
        const fileName = this.files.length > 0 ? this.files[0].name : '';
        hiddenInput.value = fileName;

        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                imagePreview.src = e.target.result;
                imagePreview.style.display = 'block';
                noImageText.style.display = 'none';
            };
            reader.readAsDataURL(file);
        } else {
            imagePreview.style.display = 'none';
            noImageText.style.display = 'block';
        }
    });
});