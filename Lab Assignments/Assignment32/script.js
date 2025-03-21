document.addEventListener("DOMContentLoaded", function () {
    const registerForm = document.getElementById("registerForm");
    if (registerForm) {
        registerForm.addEventListener("submit", function (event) {
            event.preventDefault();
            let username = document.getElementById("username").value.trim();
            let password = document.getElementById("password").value;
            let confirmPassword = document.getElementById("confirmPassword").value;
            let email = document.getElementById("email").value.trim();
            let name = document.getElementById("name").value.trim();
            let contact = document.getElementById("contact").value.trim();

            if (password !== confirmPassword) {
                document.getElementById("errorMsg").textContent = "Passwords do not match!";
                return;
            }

            // AJAX request to create.jsp
            fetch("create.jsp", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: `username=${username}&password=${password}&email=${email}&name=${name}&contact=${contact}`
            })
            .then(response => response.text())
            .then(data => {
                if (data.includes("success")) {
                    window.location.href = "login.html";
                } else {
                    document.getElementById("errorMsg").textContent = data;
                }
            });
        });
    }

    // Login form submission
    const loginForm = document.getElementById("loginForm");
    if (loginForm) {
        loginForm.addEventListener("submit", function (event) {
            event.preventDefault();
            let username = document.getElementById("loginUsername").value.trim();
            let password = document.getElementById("loginPassword").value;

            // AJAX request to login.jsp
            fetch("login.jsp", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: `username=${username}&password=${password}`
            })
            .then(response => response.text())
            .then(data => {
                if (data.includes("success")) {
                    alert("Login successful!");
                    window.location.href = "dashboard.html";
                } else {
                    document.getElementById("loginErrorMsg").textContent = "Invalid username or password!";
                }
            });
        });
    }
});
