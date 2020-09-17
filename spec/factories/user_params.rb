FactoryBot.define do
  factory :user_params, class: Hash do
    first_name { "MyString" }
    last_name { "MyString" }

    trait :invalid do
      first_name { "" }
      last_name { "" }
    end

    initialize_with { attributes }
  end
end
