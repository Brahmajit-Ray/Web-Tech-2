function factorial(n) {
    if (n === 0 || n === 1) return 1;
    return n * factorial(n - 1);
}

self.onmessage = function(event) {
    let num = parseInt(event.data);
    let results = [];

    for (let i = 1; i <= num; i++) {
        results.push({ number: i, factorial: factorial(i) });
    }

    setTimeout(()=>{self.postMessage(results)},600); 
}