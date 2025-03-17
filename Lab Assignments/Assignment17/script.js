let ws = new WebSocket("ws://localhost:8080/Assignment17/chat");

ws.onopen = () => console.log("Connected to WebSocket");

ws.onmessage = (event) => {
    let chatBox = document.getElementById("chat-box");
    chatBox.innerHTML += `<p>${event.data}</p>`;
    chatBox.scrollTop = chatBox.scrollHeight; // Auto-scroll to latest message
};

function sendMessage() {
    let input = document.getElementById("message");
    if (input.value.trim() !== "") {
        ws.send(input.value);
        input.value = "";
    }
}
