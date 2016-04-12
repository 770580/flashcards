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
    inc_time = [0, 12.hours, 3.days, 7.days, 2.weeks, 1.month]
    describe "if check result true" do
      for i in 1..5
        before do
          card = FactoryGirl.create(:card, user: user, deck: deck, box: i)
        end

        it "box #{i} plus #{inc_time[i]}" do
          card.inc_review_date(card, true)
          expect(card.review_date).to be_within(2.seconds).of(Time.zone.now + inc_time[card.box])
        end
      end
    end

    it "if check result false 3 times review_date should be plus 12 hours" do
      3.times { card.inc_review_date(card, false) }
      expect(card.review_date).to be_within(2.seconds).of(Time.zone.now + inc_time[1])
    end
  end
end
