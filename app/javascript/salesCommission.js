function catchPrice (){
  const price = document.getElementById("item-price");
  const tax = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  if (null == price) return;

  price.addEventListener('input', () => {
    const p = price.value;
    const t = Math.floor( p * 0.1 );

    tax.textContent = t.toLocaleString();
    profit.textContent = (p - t).toLocaleString();
  });
};

window.addEventListener('load', catchPrice);