let db;
let actionType = "";

// Open IndexedDB
let request = indexedDB.open("ComputerDB", 2); // Version changed for updating schema

request.onupgradeneeded = function(event) {
    let db = event.target.result;

    // Delete old object store if exists
    if (db.objectStoreNames.contains("components")) {
        db.deleteObjectStore("components");
    }

    // Create new object store with auto-incrementing product_id
    let store = db.createObjectStore("components", { keyPath: "product_id", autoIncrement: true });
    store.createIndex("name", "name", { unique: false });
    store.createIndex("manufacturer", "manufacturer", { unique: false });

    // Insert default data
    store.add({ name: "HDD", manufacturer: "Seagate", price: 80, category: "Storage" });
    store.add({ name: "Monitor", manufacturer: "Dell", price: 150, category: "Display" });
    store.add({ name: "Keyboard", manufacturer: "Logitech", price: 30, category: "Input" });
};

request.onsuccess = function(event) {
    db = event.target.result;
    showItems();  // Automatically show data on load
};

// Show dialog box
function showDialog(type) {
    actionType = type;
    document.getElementById("dialog-title").innerText = type.toUpperCase() + " Component";

    let productIdField = document.getElementById("product_id");
    let nameField = document.getElementById("name");
    let manufacturerField = document.getElementById("manufacturer");
    let priceField = document.getElementById("price");
    let categoryField = document.getElementById("category");

    if (type === "delete") {
        productIdField.disabled = false;
        nameField.style.display = "none";
        manufacturerField.style.display = "none";
        priceField.style.display = "none";
        categoryField.style.display = "none";
    } else {
        productIdField.disabled = type === "add";
        nameField.style.display = "block";
        manufacturerField.style.display = "block";
        priceField.style.display = "block";
        categoryField.style.display = "block";
    }

    document.getElementById("dialog").style.display = "block";
}

// Close dialog box
function closeDialog() {
    document.getElementById("dialog").style.display = "none";
}

// Submit data based on action type
function submitData() {
    let productId = document.getElementById("product_id").value;
    let name = document.getElementById("name").value;
    let manufacturer = document.getElementById("manufacturer").value;
    let price = document.getElementById("price").value;
    let category = document.getElementById("category").value;

    let transaction = db.transaction("components", "readwrite");
    let store = transaction.objectStore("components");

    let data = { name, manufacturer, price, category };

    if (actionType === "add") {
        store.add(data);
    } else if (actionType === "update") {
        data.product_id = Number(productId);
        store.put(data);
    } else if (actionType === "delete") {
        store.delete(Number(productId));
    }

    transaction.oncomplete = function() {
        alert(actionType.charAt(0).toUpperCase() + actionType.slice(1) + " successful!");
        closeDialog();
        showItems();
    };
}

// Show all stored items
function showItems() {
    let table = document.getElementById("data-table");
    table.innerHTML = `<tr>
        <th>Product ID</th>
        <th>Name</th>
        <th>Manufacturer</th>
        <th>Price</th>
        <th>Category</th>
    </tr>`;

    let transaction = db.transaction("components", "readonly");
    let store = transaction.objectStore("components");
    let request = store.openCursor();

    request.onsuccess = function(event) {
        let cursor = event.target.result;
        if (cursor) {
            let row = `<tr>
                <td>${cursor.value.product_id}</td>
                <td>${cursor.value.name}</td>
                <td>${cursor.value.manufacturer}</td>
                <td>${cursor.value.price}</td>
                <td>${cursor.value.category}</td>
            </tr>`;
            table.innerHTML += row;
            cursor.continue();
        }
    };
}

// Add 3 default rows when button is clicked
function addDefaultRows() {
    let transaction = db.transaction("components", "readwrite");
    let store = transaction.objectStore("components");

    let defaultData = [
        { name: "Mouse", manufacturer: "HP", price: 25, category: "Input" },
        { name: "SSD", manufacturer: "Samsung", price: 100, category: "Storage" },
        { name: "Graphics Card", manufacturer: "NVIDIA", price: 300, category: "GPU" }
    ];

    defaultData.forEach(item => store.add(item));

    transaction.oncomplete = function() {
        alert("Default rows added!");
        showItems();
    };
}
