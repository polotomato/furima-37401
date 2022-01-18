function catchPrice (){
  var price = document.getElementById("item-price");
  var tax = document.getElementById("add-tax-price");
  var profit = document.getElementById("profit");

  if (null == price) return;

  price.addEventListener('input', () => {
    var p = price.value;
    var t = Math.floor( p * 0.1 );

    tax.textContent = t.toLocaleString();
    profit.textContent = (p - t).toLocaleString();
  });
};

window.addEventListener('load', catchPrice);