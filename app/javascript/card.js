const pay = () => {
  const submit = document.getElementById("button");
  if (null == submit) return;

  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  submit.addEventListener("click", (e) => {
    e.preventDefault();
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    // カード情報を取得
    const card = {
      number: formData.get("purchase_item[number]"),
      cvc: formData.get("purchase_item[cvc]"),
      exp_month: formData.get("purchase_item[exp_month]"),
      exp_year: `20${formData.get("purchase_item[exp_year]")}`,
    };

    // PAYJPへカード情報を送信
    Payjp.createToken(card, (status, response) => {
      // 成功時、トークンを受信し、非表示の欄に格納
      if (status == 200) {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden"> `;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      };

      // 入力欄をクリア
      document.getElementById("order_number").removeAttribute("name");
      document.getElementById("order_cvc").removeAttribute("name");
      document.getElementById("order_exp_month").removeAttribute("name");
      document.getElementById("order_exp_year").removeAttribute("name");

      // トークンをサーバーサイドへ送信
      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay);