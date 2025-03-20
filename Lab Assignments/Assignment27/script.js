document.getElementById("changePassBtn").addEventListener("click", function () {
    let oldPass = document.getElementById("oldPass").value;
    let newPass = document.getElementById("newPass").value;
    let username=document.getElementById("username").value;
    let confirmPass = document.getElementById("confirmPass").value;
    let responseMsg = document.getElementById("responseMsg");

    // Validation
    if (newPass !== confirmPass) {
        responseMsg.style.color = "red";
        responseMsg.innerText = "New passwords do not match!";
        return;
    }

    // Send AJAX request
    let xhr = new XMLHttpRequest();
    xhr.open("POST", "changePassword.jsp", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                responseMsg.style.color = "green";
                responseMsg.innerText = xhr.responseText;
            } else {
                responseMsg.style.color = "red";
                responseMsg.innerText = "Error changing password!";
            }
        }
    };

    xhr.send(`username=${username}&oldPass=${oldPass}&newPass=${newPass}`);
});
