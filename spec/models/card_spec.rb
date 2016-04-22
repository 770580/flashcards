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
      answer_timer = 9
      input_text = "Дом"
      quality = card.answer_quality(input_text, answer_timer)
      expect(quality).to eq(5)
    end

    it "should be 4" do
      answer_timer = 13
      input_text = "Дом"
      quality = card.answer_quality(input_text, answer_timer)
      expect(quality).to eq(4)
    end

    it "should be 3" do
      answer_timer = 16
      input_text = "Дом"
      quality = card.answer_quality(input_text, answer_timer)
      expect(quality).to eq(3)
    end

    it "should be 3 with misprint 1" do
      answer_timer = 3
      input_text = "Домм"
      quality = card.answer_quality(input_text, answer_timer)
      expect(quality).to eq(3)
    end

    it "should be 2 with misprint 2" do
      answer_timer = 3
      input_text = "Доммм"
      quality = card.answer_quality(input_text, answer_timer)
      expect(quality).to eq(2)
    end

    it "should be 1 with misprint 3" do
      answer_timer = 3
      input_text = "Домммм"
      quality = card.answer_quality(input_text, answer_timer)
      expect(quality).to eq(1)
    end

    it "should be 3 with misprint > 3" do
      answer_timer = 3
      input_text = "Доммммм"
      quality = card.answer_quality(input_text, answer_timer)
      expect(quality).to eq(0)
    end
  end

  describe "check result" do
    answer_timer = 3  
    it "should be right" do
      input_text = "Дом"
      result = card.check(input_text, answer_timer)
      expect(result).to eq("right")
    end

    it "should be misprint 1" do
      input_text = "Домм"
      result = card.check(input_text, answer_timer)
      expect(result).to eq("misprint")
    end

    it "should be misprint 2" do
      input_text = "Доммм"
      result = card.check(input_text, answer_timer)
      expect(result).to eq("misprint")
    end

    it "should be misprint 3" do
      input_text = "Домммм"
      result = card.check(input_text, answer_timer)
      expect(result).to eq("misprint")
    end

    it "should be misprint 4" do
      input_text = "Домммммм"
      result = card.check(input_text, answer_timer)
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
