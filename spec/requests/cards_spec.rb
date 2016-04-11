require 'rails_helper'

describe "Card pages" do
  let(:user) { FactoryGirl.create(:user) }
  let(:deck) { FactoryGirl.create(:deck, user: user) }
  let!(:card) { FactoryGirl.create(:card, user: user, deck: deck) }

  before do
    visit root_path
    user_login user
  end

  it "when check passed should have message Верно" do
    fill_in "flash_card[input_text]", with: "Dog"
    click_button "Проверить"
    expect(page).to have_content("Верно")
  end

  it "when check not passed should have message Ошибка" do
    fill_in "flash_card[input_text]", with: "Cat"
    click_button "Проверить"
    expect(page).to have_content("Ошибка")
  end
end
