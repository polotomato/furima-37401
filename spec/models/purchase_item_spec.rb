require 'rails_helper'

RSpec.describe PurchaseItem, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order = FactoryBot.build(:purchase_item, user_id: user.id, item_id: item.id)
      sleep(0.01)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@order).to be_valid
      end
      it '建物名は空でも保存できる' do
        @order.building_name = ''
        expect(@order).to be_valid
      end
    end
    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できない' do
        @order.postal_code = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できない' do
        @order.postal_code = '1-936759'
        @order.valid?
        expect(@order.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'postal_codeが半角のハイフンがないと保存できない' do
        @order.postal_code = '1110000'
        @order.valid?
        expect(@order.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'postal_codeが半角の英字を含むと保存できない' do
        @order.postal_code = '111-00xx'
        @order.valid?
        expect(@order.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it '都道府県を選択していないと保存できない' do
        @order.prefecture_id = 1
        @order.valid?
        expect(@order.errors.full_messages).to include("Prefecture can't be blank")
      end
      it "市区町村が空では登録できない" do
        @order.city = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("City can't be blank")
      end
      it "番地が空では登録できない" do
        @order.address_line = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Address line can't be blank")
      end
      it "電話番号が空では登録できない" do
        @order.phone_number = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone number can't be blank")
      end
      it "電話番号が10桁未満では登録できない" do
        @order.phone_number = '123456789'
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone number is invalid. Input a 10 or 11 digit number")
      end
      it "電話番号が12桁を超えると登録できない" do
        @order.phone_number = '123456789012'
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone number is invalid. Input a 10 or 11 digit number")
      end
      it "電話番号に半角数値以外が入ると登録できない" do
        @order.phone_number = '03-00001111'
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone number is invalid. Input a 10 or 11 digit number")
      end
      it "電話番号は全角で登録できない" do
        @order.phone_number = '１２３４５６７８９０'
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone number is invalid. Input a 10 or 11 digit number")
      end
      it "tokenが空では登録できない" do
        @order.token = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Token is blank. There is something wrong with your credit card")
      end
      it 'userが紐付いていないと保存できない' do
        @order.user_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できない' do
        @order.item_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Item can't be blank")
      end
      it "エラーメッセージに重複がない" do
        @order = PurchaseItem.new
        @order.prefecture_id = 1
        @order.valid?
        ary = @order.errors.full_messages
        expect(ary.count == ary.uniq.count).to eq(true)
      end
    end
  end
end
