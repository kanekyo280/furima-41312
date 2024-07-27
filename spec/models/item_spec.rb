require 'rails_helper'


RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

describe '出品情報登録' do
  context '出品できるとき' do
    it 'imageとproduct_name、description、category、product_status、delivery_area、delivery_day、postage_payer、priceが存在すれば登録できる' do
      expect(@item).to be_valid
    end
  end
  context '出品できないとき' do
    it 'imageが空では登録できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end
    it 'product_nameが空では登録できない' do
      @item.product_name = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Product name can't be blank")
    end
    it 'descriptionが空では登録できない' do
      @item.description= ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Description can't be blank")
    end
    it 'categoryが選択肢「---」では登録できない' do
      @item.category_id = "1"
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end
    it 'product_statusが選択肢「---」では登録できない' do
      @item.product_status_id = "1"
      @item.valid?
      expect(@item.errors.full_messages).to include("Product status can't be blank")
    end
    it 'postage_payerが選択肢「---」では登録できない' do
      @item.postage_payer_id = "1"
      @item.valid?
      expect(@item.errors.full_messages).to include("Postage payer can't be blank")
    end
    it 'delivery_areaが選択肢「---」では登録できない'  do
      @item.delivery_area_id = "1"
      @item.valid?
      expect(@item.errors.full_messages).to include("Delivery area can't be blank")
    end
    it 'delivery_dayが選択肢「---」では登録できない' do
      @item.delivery_day_id = "1"
      @item.valid?
      expect(@item.errors.full_messages).to include("Delivery day can't be blank")
    end
    it 'priceが空では登録できない' do
      @item.price = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end
    it '半角数値でないとpriceが登録できない' do
      @item.price = "３４５２４５"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not a number")
    end
    it 'priceが299以下の場合は保存できない' do
      @item.price = "299"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
    end
    it 'priceが10,000,000以上の場合は保存できない' do
      @item.price = "10000000"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
    end
    it 'ユーザーが紐付いていなければ投稿できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("User must exist")
    end
  end
end
end
