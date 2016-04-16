FactoryGirl.define do
  factory :card do
    original_text "Dog"
    translated_text "Собака"
    review_date Date.today
    user
    deck
  end

  factory :user do
    sequence(:email) { |n| "user_#{n}@example.com" }
    password "asdf"
    password_confirmation "asdf"
  end

  factory :deck do
    name "english"
    active "true"
    user
  end
end
