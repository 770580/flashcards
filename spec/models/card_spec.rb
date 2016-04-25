require 'rails_helper'

describe Card do
  let(:card) { FactoryGirl.create(:card, original_text: "Дом", translated_text: "House") }

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

  describe "check result" do
    it "should be right" do
      result = card.check_and_inc_review_date("Дом", 3)
      expect(result[:correct]).to eq(true)
    end

    it "should be misprint 1" do
      result = card.check_and_inc_review_date("Домм", 3)
      expect(result[:correct]).to eq(true)
      expect(result[:misprints_count]).to eq(1)
    end

    it "should be misprint 2" do
      result = card.check_and_inc_review_date("Доммм", 3)
      expect(result[:correct]).to eq(true)
      expect(result[:misprints_count]).to eq(2)
    end

    it "should be misprint 3" do
      result = card.check_and_inc_review_date("Домммм", 3)
      expect(result[:correct]).to eq(true)
      expect(result[:misprints_count]).to eq(3)
    end

    it "should be misprint 4" do
      result = card.check_and_inc_review_date("Домммммм", 3)
      expect(result[:correct]).to eq(false)
    end
  end

  describe "inc review date" do
    it "quality 5 and repetition 1" do
      card.check_and_inc_review_date("Дом", 3)
      expect(card.review_date).to be_within(2.seconds).of(Time.zone.now + 1.day)
    end

    it "quality 5 and repetition 2" do
      card.update(repetition: 2)
      card.check_and_inc_review_date("Дом", 3)
      expect(card.review_date).to be_within(2.seconds).of(Time.zone.now + 6.days)
    end

    it "quality 5 and repetition 3" do
      card.update(repetition: 3, interval: 6, e_factor: 2.6)
      card.check_and_inc_review_date("Дом", 3)
      expect(card.review_date).to be_within(2.seconds).of(Time.zone.now + 16.days)
    end

    it "quality < 3 after previos 5 and repetition 3" do
      card.update(repetition: 3, interval: 6, e_factor: 2.6)
      card.check_and_inc_review_date("Домммммм", 3)
      expect(card.review_date).to be_within(2.seconds).of(Time.zone.now + 1.days)
    end
  end
end
