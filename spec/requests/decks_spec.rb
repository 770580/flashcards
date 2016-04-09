require 'rails_helper'

describe Deck do
  let(:user) { FactoryGirl.create(:user) }
  let!(:deck) { FactoryGirl.create(:deck, user_id: user.id) }
  before do
    visit root_path
    user_login user
    visit decks_path
  end

  it "should be button Новая колода" do
    expect(page).to have_content("Новая колода")
  end

  describe "create new deck" do
    before { click_link "Новая колода" }

    it "not active" do
      fill_in "Название колоды", with: "First"
      expect { click_button "Создать" }.to change(Deck, :count).by(1)
    end

    it "active" do
      fill_in "Название колоды", with: "First"
      check "Сделать активной"
      expect { click_button "Создать" }.to change(Deck, :count).by(1)
    end
  end
end
