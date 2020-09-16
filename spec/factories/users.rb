FactoryBot.define do
  factory :user do
    first_name { "MyString" }
    last_name { "MyString" }

    trait :invalid do
      first_name { "" }
      last_name { "" }
    end

    trait :synced do
      remote_id { [*1..100000].sample }
    end
  end
end
