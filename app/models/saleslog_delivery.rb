class SaleslogDelivery
  include ActiveModel::Model
  attr_accessor :postal_code, :delivery_area_id, :address_city, :address_house_number, :address_building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
  validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  validates :address_city
  validates :address_house_number
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'must be a number with 10 to 11 digits' }
  validates :user_id
  validates :item_id
  validates :token

  with_options numericality: { other_than: 1 , message: "can't be blank"} do
    validates :delivery_area_id
  end
end

def save
  saleslog = Saleslog.create(item_id: item_id, user_id: user_id)
  Delivery.create(postal_code: postal_code, delivery_area_id: delivery_area_id, address_city: address_city, address_house_number: address_house_number, address_building_name: address_building_name, phone_number: phone_number, saleslog_id: saleslog.id)
end
end
