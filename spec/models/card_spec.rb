require 'rails_helper'

describe Card do
  let(:card){ Card.new(original_text: "Дом", translated_text: "House", review_date: Date.today) }

  it "when original_text and translated_text equal should be invalid" do
    bad_words = %w[Дом ДоМ доМ]
    bad_words.each do |word|
      card.translated_text = word
      expect(card).not_to be_valid
    end
  end

  it "random card should be exist" do
    card.save
    card_r = Card.random
    expect(card).to eq(card_r)
  end

  it "add 3 days in review_date should be valid" do
    card.inc_review_date
    expect(card.review_date).to eq(Date.today + 3.days)
  end
end
