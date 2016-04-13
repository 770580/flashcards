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

  describe "if check result true add time in review_date" do

    it "12 hours" do
      card.inc_review_date(true)
      expect(card.review_date).to be_within(2.seconds).of(Time.zone.now + 12.hours)
    end

    it "plus 3 days" do
      card.update(level: 1)
      card.inc_review_date(true)
      expect(card.review_date).to be_within(2.seconds).of(Time.zone.now + 3.days)
    end

    it "plus 7 days" do
      card.update(level: 2)
      card.inc_review_date(true)
      expect(card.review_date).to be_within(2.seconds).of(Time.zone.now + 7.days)
    end

    it "plus 2 weeks" do
      card.update(level: 3)
      card.inc_review_date(true)
      expect(card.review_date).to be_within(2.seconds).of(Time.zone.now + 2.weeks)
    end

    it "plus 1 month" do
      card.update(level: 4)
      card.inc_review_date(true)
      expect(card.review_date).to be_within(2.seconds).of(Time.zone.now + 1.month)
    end
  end

  it "if check result false 3 times review_date should be plus 12 hours" do
    3.times { card.inc_review_date(false) }
    expect(card.review_date).to be_within(2.seconds).of(Time.zone.now + 12.hours)
  end
end
