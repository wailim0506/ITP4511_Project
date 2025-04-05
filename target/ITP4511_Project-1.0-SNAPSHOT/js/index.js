/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

document.addEventListener('DOMContentLoaded', function () {
    const rememberedUsername = localStorage.getItem('rememberedUsername');
    const rememberedPassword = localStorage.getItem('rememberedPassword');

    if (rememberedUsername && rememberedPassword) {
        document.getElementById('username').value = rememberedUsername;
        document.getElementById('password').value = rememberedPassword;
        document.getElementById('rememberMe').checked = true;
    }

    const loginForm = document.querySelector('form');
    loginForm.addEventListener('submit', function () {
        const rememberMeCheckbox = document.getElementById('rememberMe');
        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;

        if (rememberMeCheckbox.checked) {
            localStorage.setItem('rememberedUsername', username);
            localStorage.setItem('rememberedPassword', password);
        } else {
            localStorage.removeItem('rememberedUsername');
            localStorage.removeItem('rememberedPassword');
        }
    });
});