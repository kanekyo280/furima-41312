FactoryBot.define do
  factory :item do
    product_name            {Faker::Commerce.product_name}
    description             {Faker::Lorem.sentence}
    category_id             {Faker::Number.between(from: 2, to: 3)}
    product_status_id        {Faker::Number.between(from: 2, to: 3)}
    postage_payer_id         {Faker::Number.between(from: 2, to: 3)}
    delivery_area_id        {Faker::Number.between(from: 2, to: 30)}
    delivery_day_id          {Faker::Number.between(from: 2, to: 3)}
    price                   {Faker::Number.between(from: 300, to: 10000)}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('app/assets/images/flag.png'), filename: 'flag.png')
    end
  end
end
