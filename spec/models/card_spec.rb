require 'rails_helper'

describe Card do
  let(:user) { FactoryGirl.create(:user) }
  let(:deck) { FactoryGirl.create(:deck, user: user) }
  let(:card) { FactoryGirl.create(:card, original_text: "Дом", translated_text: "House", user: user, deck: deck) }

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

  describe "add time in review_date" do
    it "box 1 plus 12 hours" do
      card.inc_review_date(1)
      expect(card.review_date).to be_within(2.seconds).of(Time.zone.now + 12.hours)
    end

    it "box 2 plus 3 days" do
      card.inc_review_date(2)
      expect(card.review_date).to be_within(2.seconds).of(Time.zone.now + 3.days)
    end

    it "box 3 plus 7 days" do
      card.inc_review_date(3)
      expect(card.review_date).to be_within(2.seconds).of(Time.zone.now + 7.days)
    end

    it "box 4 plus 2 weeks" do
      card.inc_review_date(4)
      expect(card.review_date).to be_within(2.seconds).of(Time.zone.now + 2.weeks)
    end

    it "box 5 plus 1 month" do
      card.inc_review_date(5)
      expect(card.review_date).to be_within(2.seconds).of(Time.zone.now + 1.month)
    end
  end
end
