require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

describe 'ユーザー新規登録' do
  context '新規登録できるとき' do
    it 'nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
      expect(@user).to be_valid
    end
  end
  context '新規登録できないとき' do
    it 'nicknameが空では登録できない' do
      @user.nickname = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'emailが空では登録できない' do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'passwordが空では登録できない' do
      @user.password = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'passwordとpassword_confirmationが不一致では登録できない' do
      @user.password = "123456"
      @user.password_confirmation = "113456"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it '重複したemailが存在する場合は登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
    it 'emailは@を含まないと登録できない' do
      @user.email = "testtest"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end
    it 'passwordが5文字以下では登録できない' do
      @user.password = "kane"
      @user.password_confirmation = "kane"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it '半角英字のみでは登録できない' do
      @user.password = "kanemura"
      @user.password_confirmation = "kanemura"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end
    it '半角数字のみでは登録できない' do
      @user.password = "56756755"
      @user.password_confirmation = "56756755"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end
    it '全角文字を含むパスワードでは登録できない' do
      @user.password = "かねむら"
      @user.password_confirmation = "かねむら"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end
    it 'passwordが129文字以上では登録できない' do
      @user.password = Faker::Internet.password(min_length: 129, max_length: 150)
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
    end
    it '苗字(全角)が空では登録できない' do
      @user.first_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it '名前(全角)が空では登録できない' do
      @user.last_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it '苗字が半角では登録できない' do
      @user.first_name = "kanemura"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name is invalid")
    end
    it '名前が半角では登録できない' do
      @user.last_name = "kanemura"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name is invalid")
    end
    it '苗字(カナ)が空では登録できない' do
      @user.first_name_reading = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name reading can't be blank")
    end
    it '名前(カナ)が空では登録できない' do
      @user.last_name_reading = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name reading can't be blank")
    end
    it '苗字がカタカナ以外では登録できない' do
      @user.first_name_reading = "kanemura"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name reading is invalid")
    end
    it '名前がカタカナ以外では登録できない' do
      @user.last_name_reading = "kanemura"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name reading is invalid")
    end
    it '生年月日が空白だと登録できない' do
      @user.birthday = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end
end
