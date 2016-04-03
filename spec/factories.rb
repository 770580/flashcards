FactoryGirl.define do
  factory :card do
    original_text "Dog"
    translated_text "Собака"
    review_date Date.today
  end
end
