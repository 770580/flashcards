require 'rails_helper'

describe Deck do
  let(:user) { FactoryGirl.create(:user) }
  let!(:deck) { FactoryGirl.create(:deck, user: user) }
  before do
    visit root_path
    user_login user
    visit dashboard_decks_path
  end

  it "should be button Новая колода" do
    expect(page).to have_content("Новая колода")
  end

  describe "create new deck" do
    before { click_link I18n.t('decks.new_deck_link') }

    it "not active" do
      fill_in I18n.t('decks.deck_name_label'), with: "First"
      expect { click_button I18n.t('form_submit.new') }.to change(Deck, :count).by(1)
    end

    it "active" do
      fill_in I18n.t('decks.deck_name_label'), with: "First"
      check I18n.t('decks.deck_active_label')
      expect { click_button I18n.t('form_submit.new') }.to change(Deck, :count).by(1)
    end
  end
end
