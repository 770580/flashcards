FactoryGirl.define do
  factory :card do
    original_text "Dog"
    translated_text "Собака"
    review_date Date.today
  end

  factory :user do
    email "user@user.ru"
    password "asdf"
    password_confirmation "asdf"
  end
end
