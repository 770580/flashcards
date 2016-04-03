FactoryGirl.define do
  factory :card do
    original_text "Dog"
    translated_text "Собака"
    review_date Date.today
  end

  factory :user do
    email "a@a.ru"
    password "aaa"
    password_confirmation "aaa"
  end
end
