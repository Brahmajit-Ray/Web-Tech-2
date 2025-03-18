// Function to calculate factorial
const factorial = (n) => (n === 0 || n === 1 ? 1 : n * factorial(n - 1));

// Handle messages from main script
self.onmessage = (event) => {
    const number = event.data;
    const results = Array.from({ length: number }, (_, i) => `${i + 1}! = ${factorial(i + 1)}`);

    // Send back results
    self.postMessage(results);
};
