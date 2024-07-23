FactoryBot.define do
  factory :user do

    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.email}
    password              {'1a' + Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    first_name            {Gimei.first.kanji}
    last_name             {Gimei.last.kanji}
    first_name_reading    {Gimei.first.katakana}
    last_name_reading     {Gimei.last.katakana}
  birthday                {Faker::Date.between(from: '1990-01-01', to:'2020-12-08')}
  end
end
