window.onload = function () {
    const components = ["hdd", "motherboard", "processor", "ram", "monitor", "cd"];
    
    components.forEach(component => {
        fetch(`GetComponents.jsp?type=${component}`)
            .then(response => response.json())
            .then(data => {
                let dropdown = document.getElementById(component);
                let noneOption = document.createElement("option");
                noneOption.value = "None";
                noneOption.textContent = "None";
                dropdown.appendChild(noneOption);
                data.forEach(item => {
                    let option = document.createElement("option");
                    option.value = item.model;
                    option.textContent = `${item.manufacturer} - ${item.model} (₹${item.price})`;
                    dropdown.appendChild(option);
                });
                dropdown.value="None";
            });
    });
};
