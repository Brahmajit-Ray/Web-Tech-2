document.addEventListener("DOMContentLoaded", () => {
    const loginNameInput = document.getElementById("loginName");
    const availabilitySpan = document.getElementById("availability");

    loginNameInput.addEventListener("input", () => {
        const loginName = loginNameInput.value.trim();
        if (loginName.length < 3) {
            availabilitySpan.textContent = "Too short";
            availabilitySpan.style.color = "red";
            return;
        }

        // AJAX request to check username availability
        const xhr = new XMLHttpRequest();
        xhr.open("POST", "checkAvailability.jsp", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        xhr.onreadystatechange = () => {
            if (xhr.readyState === 4 && xhr.status === 200) {
                if (xhr.responseText.trim() === "available") {
                    availabilitySpan.textContent = "Available";
                    availabilitySpan.style.color = "green";
                } else {
                    availabilitySpan.textContent = "Already taken";
                    availabilitySpan.style.color = "red";
                }
            }
        };

        xhr.send("loginName=" + encodeURIComponent(loginName));
    });
});
