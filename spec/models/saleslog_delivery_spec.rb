require 'rails_helper'

RSpec.describe SaleslogDelivery, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @log = FactoryBot.build(:saleslog_delivery, user_id: user.id, item_id: item.id)
  end

describe '購入登録' do
  context '購入登録できるとき' do
    it 'postal_codeとdelivery_area_id、address_cityとaddress_house_numberとtokenが存在すれば登録できる' do
      expect(@log).to be_valid
    end
    it ' address_building_nameが存在しなくても登録できる' do
      @log.address_building_name = ""
      expect(@log).to be_valid
    end
  end
  context '購入登録できないとき' do
    it 'postal_codeが空では登録できない' do
      @log.postal_code = ""
      @log.valid?
      expect(@log.errors.full_messages).to include("Postal code can't be blank")
    end
    it 'delivery_areaが選択肢「---」では登録できない'  do
      @log.delivery_area_id = "1"
      @log.valid?
      expect(@log.errors.full_messages).to include("Delivery area can't be blank")
    end
    it 'address_cityが空では登録できない' do
      @log.address_city = ""
      @log.valid?
      expect(@log.errors.full_messages).to include("Address city can't be blank")
    end
    it 'address_house_numberが空では登録できない' do
      @log.address_house_number = ""
      @log.valid?
      expect(@log.errors.full_messages).to include("Address house number can't be blank")
    end
    it 'tokenが空では登録できない' do
      @log.token = ""
      @log.valid?
      expect(@log.errors.full_messages).to include("Token can't be blank")
    end
    it 'postal_codeはハイフンを含まないと登録できない' do
      @log.postal_code = "9879876"
      @log.valid?
      expect(@log.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
    end
    it 'phone_numberが空では登録できない' do
      @log.phone_number = ""
      @log.valid?
      expect(@log.errors.full_messages).to include("Phone number can't be blank")
    end
    it 'phone_numberが9桁以下では登録できない' do
      @log.phone_number = "139573"
      @log.valid?
      expect(@log.errors.full_messages).to include("Phone number must be a number with 10 to 11 digits")
    end
    it 'phone_numberが11桁以上では登録できない' do
      @log.phone_number = "139573947256482364"
      @log.valid?
      expect(@log.errors.full_messages).to include("Phone number must be a number with 10 to 11 digits")
    end
    it 'phone_numberが数字以外では登録できない' do
      @log.phone_number = "hfueeivjmv"
      @log.valid?
      expect(@log.errors.full_messages).to include("Phone number must be a number with 10 to 11 digits")
    end
    it 'userが紐付いていなければ投稿できない' do
      @log.user_id = nil
      @log.valid?
      expect(@log.errors.full_messages).to include("User can't be blank")
    end
    it 'itemが紐付いていなければ投稿できない' do
      @log.item_id = nil
      @log.valid?
      expect(@log.errors.full_messages).to include("Item can't be blank")
    end
  end
end
end
