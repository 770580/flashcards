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

  describe "card quality" do
    it "should be 5" do
      quality = card.answer_quality("Дом", 9)
      expect(quality).to eq(5)
    end

    it "should be 4" do
      quality = card.answer_quality("Дом", 13)
      expect(quality).to eq(4)
    end

    it "should be 3" do
      quality = card.answer_quality("Дом", 16)
      expect(quality).to eq(3)
    end

    it "should be 3 with misprint 1" do
      quality = card.answer_quality("Домм", 3)
      expect(quality).to eq(3)
    end

    it "should be 2 with misprint 2" do
      quality = card.answer_quality("Доммм", 3)
      expect(quality).to eq(2)
    end

    it "should be 1 with misprint 3" do
      quality = card.answer_quality("Домммм", 3)
      expect(quality).to eq(1)
    end

    it "should be 3 with misprint > 3" do
      quality = card.answer_quality("Доммммм", 3)
      expect(quality).to eq(0)
    end
  end

  describe "check result" do
    it "should be right" do
      result = card.check("Дом", 3)
      expect(result).to eq(true)
    end

    it "should be misprint 1" do
      result = card.check("Домм", 3)
      expect(result).to eq("misprint")
    end

    it "should be misprint 2" do
      result = card.check("Доммм", 3)
      expect(result).to eq("misprint")
    end

    it "should be misprint 3" do
      result = card.check("Домммм", 3)
      expect(result).to eq("misprint")
    end

    it "should be misprint 4" do
      result = card.check("Домммммм", 3)
      expect(result).to eq(nil)
    end
  end

  describe "inc review date" do
    it "quality 5 and repetition 1" do
      card.inc_review_date(5)
      expect(card.review_date).to be_within(2.seconds).of(Time.zone.now + 1.day)
    end

    it "quality 5 and repetition 2" do
      card.update(repetition: 2)
      card.inc_review_date(5)
      expect(card.review_date).to be_within(2.seconds).of(Time.zone.now + 6.days)
    end

    it "quality 5 and repetition 3" do
      card.update(repetition: 3, interval: 6, e_factor: 2.6)
      card.inc_review_date(5)
      expect(card.review_date).to be_within(2.seconds).of(Time.zone.now + 16.days)
    end

    it "quality < 3 after previos 5 and repetition 3" do
      card.update(repetition: 3, interval: 6, e_factor: 2.6)
      card.inc_review_date(2)
      expect(card.review_date).to be_within(2.seconds).of(Time.zone.now + 1.days)
    end
  end
end
