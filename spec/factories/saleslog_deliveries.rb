FactoryBot.define do
  factory :saleslog_delivery do
    postal_code              {"123-9876"}
    delivery_area_id        {Faker::Number.between(from: 2, to: 30)}
    address_city               {Faker::Address.street_address}
    address_house_number     {address_city}
    phone_number            {"0984873294"}
    token                 {Faker::Finance.credit_card}
    address_building_name   {"kanemurabill"}
  end
end
