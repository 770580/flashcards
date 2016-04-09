require 'rails_helper'

describe Deck do
  let(:deck) { Deck.new(name: "English", active: true, user_id: "1") }

  it "should be choose active deck" do
    deck.save
    deck_active = Deck.choose_active.first
    expect(deck_active.active).to eq(true)
  end

  it "should do active one deck" do
    second_deck = Deck.new(name: "French", active: true, user_id: "1")
    deck.save
    second_deck.save
    Deck.make_others_inactive(second_deck.id)
    new_deck = Deck.find(deck.id)
    expect(new_deck.active).to eq(false)
    expect(second_deck.active).to eq(true)
  end
end
