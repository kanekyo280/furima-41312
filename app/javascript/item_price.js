

const reprice = ()=>{
    const priceInput = document.getElementById("item-price");
    const taxInput = document.getElementById("add-tax-price");
    const profitInput = document.getElementById("profit");

    priceInput.addEventListener("input", () => {
        const price = priceInput.value;
        const tax = Math.floor(price * 0.1);
        const profit = price - tax;

    taxInput.innerHTML = `${tax}`
    profitInput.innerHTML = `${profit}`

    })
}

window.addEventListener("turbo:load", reprice);
window.addEventListener("turbo:render", reprice);

