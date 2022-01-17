FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname              { Faker::Internet.username }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) + "0Mg" } # 稀に種類が偏ることがある
    password_confirmation { password }
    last_name             { person.last.kanji }
    first_name            { person.first.hiragana }
    last_name_kana        { person.last.katakana }
    first_name_kana       { person.first.katakana }
    birth_date            { Faker::Date.birthday(min_age: 5) }
  end
end
