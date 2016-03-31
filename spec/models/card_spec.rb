require 'rails_helper'

describe Card do
  before { @card = Card.new(original_text: "Дом", translated_text: "House",
    						review_date: Date.today) }
  subject { @card }

  it { should respond_to(:original_text) }
  it { should respond_to(:translated_text) }
  it { should respond_to(:review_date) }

  describe "when original_text and translated_text equal" do
    it "should be invalid" do
      bad_words = %w[Дом ДоМ доМ]
      bad_words.each do |word|
        @card.translated_text = word
        expect(@card).not_to be_valid
      end
    end
  end

  describe "get random card" do
  	it "should be valid" do
  	  @card = Card.random
      expect(@card).to be_valid
  	end
  end

  describe "add 3 days in review_date" do
  	it "should be valid" do
  	  @card.inc_review_date
      expect(@card.review_date).to eq(Date.today + 3.days)
  	end
  end
end