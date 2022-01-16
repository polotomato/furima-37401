require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "全ての項目が正しく存在すれば登録できる" do
        expect(@user).to be_valid
      end
      it "first_nameが漢字でも登録できる" do
        @user.first_name = "太郎"
        expect(@user).to be_valid
      end
      it "first_nameがひらがなでも登録できる" do
        @user.first_name = "たろう"
        expect(@user).to be_valid
      end
      it "first_nameがカタカナでも登録できる" do
        @user.first_name = "タロウ"
        expect(@user).to be_valid
      end
      it "last_nameが漢字でも登録できる" do
        @user.last_name = "山田"
        expect(@user).to be_valid
      end
      it "last_nameがひらがなでも登録できる" do
        @user.last_name = "やまだ"
        expect(@user).to be_valid
      end
      it "last_nameがカタカナでも登録できる" do
        @user.last_name = "ヤマダ"
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it "nicknameが空では登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it "他のユーザーのemailと重複では登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include "Email has already been taken"
      end
      it "emailに@がないと登録できない" do
        @user.email.delete!("@")
        @user.valid?
        expect(@user.errors.full_messages).to include "Email is invalid"
      end
      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it "passwordが5文字以下では登録できない" do
        @user.password = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
      end
      it "passwordが英字のみでは登録できない" do
        @user.password = 'abcDEF'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid. Include both letters and numbers"
      end
      it "passwordが数字のみでは登録できない" do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid. Include both letters and numbers"
      end
      it "passwordに全角があると登録できない" do
        @user.password = '１２３abc567'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid. Include both letters and numbers"
      end
      it "passwordとpassword_confirmationが不一致では登録できない" do
        @user.password_confirmation = '111xxx'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it "first_nameが空では登録できない" do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end
      it "last_nameが空では登録できない" do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name can't be blank"
      end
      it "first_name_kanaが空では登録できない" do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana can't be blank"
      end
      it "last_name_kanaが空では登録できない" do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana can't be blank"
      end
      it "first_name_kanaがカタカナ以外では登録できない" do
        @user.first_name_kana = 'xxx'
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana is invalid. Input full-width katakana characters"
      end
      it "last_name_kanaがカタカナ以外では登録できない" do
        @user.last_name_kana = 'あああ'
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana is invalid. Input full-width katakana characters"
      end
      it "birth_dateが空では登録できない" do
        @user.birth_date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include "Birth date can't be blank"
      end
      it "エラーメッセージに重複がない" do
        @user = User.new
        @user.valid?
        ary = @user.errors.full_messages
        expect(ary.count == ary.uniq.count).to eq(true)
      end
    end
  end
end
