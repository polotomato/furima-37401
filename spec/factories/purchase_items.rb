FactoryBot.define do
  factory :purchase_item do
    fk = Faker::PhoneNumber
    postal_code   { fk.subscriber_number(length: 3) << '-' << fk.subscriber_number(length: 4) }
    prefecture_id { Faker::Number.within(range: 2..Prefecture.data.length) }
    city          { Gimei.city.kanji }
    address_line  { Gimei.town.kanji }
    building_name { Faker::Address.building_number }
    phone_number  { Faker::PhoneNumber.subscriber_number(length: 11) }
    token         { "tok_abcdefghijk00000000000000000" }
  end
end
