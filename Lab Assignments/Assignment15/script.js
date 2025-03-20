if (window.Worker) {
    var worker = new Worker("worker.js");

    function generateFactorials() {
        let number = document.getElementById("numInput").value;
        if (number < 1) {
            alert("Please enter a number greater than or equal to 1.");
            return;
        }
        document.getElementById("factorialTable").innerHTML = "<tr><td colspan='2'>Calculating...</td></tr>";

        worker.postMessage(number); // Send number to worker
    }

    worker.onmessage = function(event) {
        let data = event.data;
        let table = document.getElementById("factorialTable");
        table.innerHTML = ""; 

        data.forEach(entry => {
            let row = `<tr><td>${entry.number}</td><td>${entry.factorial}</td></tr>`;
            table.innerHTML += row;
        });
    };
} else {
    alert("Your browser does not support Web Workers.");
}