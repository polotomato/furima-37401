function updateValue() {
  const bb = document.getElementById("item-price");
  const tax = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");
  
  const p = bb.value;
  const t = Math.floor( p * 0.1 );

  tax.textContent = t.toLocaleString();
  profit.textContent = (p - t).toLocaleString();
};

function catchPrice (){
  const price = document.getElementById("item-price");

  if (null == price) return;

  // 編集画面用 初回ロード時、利益・手数料を表示
  updateValue();

  price.addEventListener('input', updateValue);
};

window.addEventListener('load', catchPrice);