document.getElementById("loginBtn").addEventListener("click", function() {
    let username = document.getElementById("username").value;
    let password = document.getElementById("password").value;
    let errorMsg = document.getElementById("errorMsg");

    if (username === "" || password === "") {
        errorMsg.textContent = "Please enter both username and password.";
        return;
    }

    let xhr = new XMLHttpRequest();
    xhr.open("POST", "login.jsp", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
   

    xhr.onload = function() {
        if (xhr.status === 200) {
            if (xhr.responseText.trim() === "success") {
                window.location.href = "dashboard.html"; // Redirect on success
            } else {
                errorMsg.textContent = "Invalid username or password.";
            }
        } else {
            errorMsg.textContent = "Error connecting to server.";
        }
    };

    xhr.send(`username=${encodeURIComponent(username)}&password=${encodeURIComponent(password)}`);
});
