require 'rails_helper'

describe Deck do
  let(:user) { FactoryGirl.create(:user) }
  let(:deck) { FactoryGirl.create(:deck, user: user) }

  it "should be choose active deck" do
    deck.save
    deck_active = Deck.choose_active.first
    expect(deck_active.active).to eq(true)
  end

  it "should do active one deck" do
    second_deck = FactoryGirl.create(:deck, name: "French", user: user)
    deck.save
    second_deck.save
    Deck.make_others_inactive(second_deck)
    new_deck = Deck.find(deck.id)
    expect(new_deck.active).to eq(false)
    expect(second_deck.active).to eq(true)
  end
end
