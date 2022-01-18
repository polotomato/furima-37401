require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品の新規登録' do
    context '新規登録できる場合' do
      it "全ての項目が正しく存在すれば登録できる" do
        expect(@item).to be_valid
      end
    end
    context '新規登録できない場合' do
      it "画像の添付がないと登録できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Image must be attaced"
      end
      it "商品名がないと登録できない" do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Name can't be blank"
      end
      it "商品名が40字を超えると登録できない" do
        @item.name = 'a' * 41
        @item.valid?
        expect(@item.errors.full_messages).to include "Name is too long (maximum is 40 characters)"
      end
      it "商品の説明がないと登録できない" do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Description can't be blank"
      end
      it "商品の説明が1000字を超えると登録できない" do
        @item.description = 'a' * 1001
        @item.valid?
        expect(@item.errors.full_messages).to include "Description is too long (maximum is 1000 characters)"
      end
      it "カテゴリーの情報がないと登録できない" do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Category can't be blank"
      end
      it "商品の状態の情報がないと登録できない" do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Condition can't be blank"
      end
      it "配送料の負担の情報がないと登録できない" do
        @item.shipping_fee_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Shipping fee status can't be blank"
      end
      it "発送元の地域の情報がないと登録できない" do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Prefecture can't be blank"
      end
      it "発送までの日数の情報がないと登録できない" do
        @item.scheduled_delivery_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Scheduled delivery can't be blank"
      end
      it "価格の情報がないと登録できない" do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Price can't be blank"
      end
      it "価格が¥300未満だと登録できない" do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be greater than or equal to 300"
      end
      it "価格が¥10,000,000以上だと登録できない" do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be less than or equal to 9999999"
      end
      it "価格が小数を含むと登録できない" do
        @item.price = 700.67
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be an integer"
      end
      it "価格が全角だと登録できない" do
        @item.price = "１２３" # 全角
        @item.valid?
        expect(@item.errors.full_messages).to include "Price is not a number"
      end
      it "価格が英字だと登録できない" do
        @item.price = "abc"
        @item.valid?
        expect(@item.errors.full_messages).to include "Price is not a number"
      end
      it "userが紐づいてないitemは登録できない" do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "User must exist"
      end
      it "エラーメッセージに重複がない" do
        @item = Item.new
        @item.category_id            = 1
        @item.condition_id           = 1
        @item.shipping_fee_status_id = 1
        @item.prefecture_id          = 1
        @item.scheduled_delivery_id  = 1
        @item.valid?
        ary = @item.errors.full_messages
        expect(ary.count == ary.uniq.count).to eq(true)
      end
    end
  end
end
