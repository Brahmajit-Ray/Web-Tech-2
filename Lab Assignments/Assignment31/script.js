document.getElementById("marksForm").addEventListener("submit", function(event) {
    event.preventDefault(); // Stop form from refreshing the page

    let rollNumber = document.getElementById("roll_number").value.trim();
    let semester = document.getElementById("semester").value;
    let subject = document.getElementById("subject").value;

    console.log("Sending Data:");
    console.log("Roll Number:", rollNumber);
    console.log("Semester:", semester);
    console.log("Subject:", subject);

    if (!rollNumber || !semester || !subject) {
        document.getElementById("result").innerHTML = "Please fill in all fields.";
        return;
    }

    // Use URL-encoded form submission
    let formData = new URLSearchParams();
    formData.append("roll_number", rollNumber);
    formData.append("semester", semester);
    formData.append("subject", subject);

    fetch("fetchMarks.jsp", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: formData.toString()
    })
    .then(response => response.text())
    .then(data => {
        console.log("Response from Server:", data);
        document.getElementById("result").innerHTML = data;
    })
    .catch(error => {
        console.error("Fetch Error:", error);
        document.getElementById("result").innerHTML = "Failed to fetch data.";
    });
});
