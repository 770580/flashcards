require 'rails_helper'
describe SuperMemo do
  let(:card) { FactoryGirl.create(:card, original_text: "Дом", translated_text: "House") }

  describe "interval" do
    it "when first repetition should be 1" do
      memo = SuperMemo.new(card, "Дом", 9)
      expect(memo.interval).to eq(1)
    end

    it "when second repetition should be 6" do
      card.update(repetition: 2)
      memo = SuperMemo.new(card, "Дом", 9)
      expect(memo.interval).to eq(6)
    end

    it "when third repetition should be 16" do
      card.update(repetition: 3, interval: 6, e_factor: 2.6)
      memo = SuperMemo.new(card, "Дом", 9)
      expect(memo.interval).to eq(16)
    end

    it "when quality < 3 should be 1" do
      card.update(repetition: 3, interval: 6, e_factor: 2.6)
      memo = SuperMemo.new(card, "Доммммм", 9)
      expect(memo.interval).to eq(1)
    end
  end

  describe "repetition" do
    it "should be 2 (+1)" do
      memo = SuperMemo.new(card, "Дом", 9)
      expect(memo.repetition).to eq(2)
    end

    it "when quality < 3 should be 1" do
      memo = SuperMemo.new(card, "Доммммм", 9)
      expect(memo.repetition).to eq(1)
    end
  end

  describe "e_factor" do
    it "when first repetition and quality 5 should be 2.6" do
      memo = SuperMemo.new(card, "Дом", 9)
      expect(memo.e_factor).to eq(2.6)
    end

    it "when quality 0 should be 1.3" do
      card.update(repetition: 3, interval: 6, e_factor: 1.4)
      memo = SuperMemo.new(card, "Доммммм", 9)
      expect(memo.e_factor).to eq(1.3)
    end
  end

  describe "quality" do
    it "should be 5" do
      memo = SuperMemo.new(card, "Дом", 9)
      expect(memo.quality).to eq(5)
    end

    it "should be 4" do
      memo = SuperMemo.new(card, "Дом", 13)
      expect(memo.quality).to eq(4)
    end

    it "should be 3" do
      memo = SuperMemo.new(card, "Дом", 16)
      expect(memo.quality).to eq(3)
    end

    it "should be 3 with misprint 1" do
      memo = SuperMemo.new(card, "Домм", 3)
      expect(memo.quality).to eq(3)
    end

    it "should be 2 with misprint 2" do
      memo = SuperMemo.new(card, "Доммм", 3)
      expect(memo.quality).to eq(2)
    end

    it "should be 1 with misprint 3" do
      memo = SuperMemo.new(card, "Домммм", 3)
      expect(memo.quality).to eq(1)
    end

    it "should be 3 with misprint > 3" do
      memo = SuperMemo.new(card, "Доммммм", 3)
      expect(memo.quality).to eq(0)
    end
  end
end
