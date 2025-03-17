// Initialize web worker
const worker = new Worker("worker.js");

// Listen for button click
document.getElementById("generate").addEventListener("click", () => {
    const number = parseInt(document.getElementById("number").value);
    
    if (number < 1 || isNaN(number)) {
        alert("Please enter a positive number!");
        return;
    }

    worker.postMessage(number);
});

// Receive results from worker
worker.onmessage = (event) => {
    const resultList = document.getElementById("result");
    resultList.innerHTML = ""; // Clear previous results

    event.data.forEach(item => {
        const li = document.createElement("li");
        li.textContent = item;
        resultList.appendChild(li);
    });
};

