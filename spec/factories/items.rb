FactoryBot.define do
  factory :item do
    name                     { Faker::Lorem.word }
    description              { Faker::Lorem.sentence }
    category_id              { Faker::Number.within(range: 2..Category.data.length) }
    condition_id             { Faker::Number.within(range: 2..Condition.data.length) }
    shipping_fee_status_id   { Faker::Number.within(range: 2..ShippingFeeStatus.data.length) }
    prefecture_id            { Faker::Number.within(range: 2..Prefecture.data.length) }
    scheduled_delivery_id    { Faker::Number.within(range: 2..ScheduledDelivery.data.length) }
    price                    { Faker::Number.within(range: 300..9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/sold_cat.jpeg'), filename: 'test_image.png')
    end
  end
end