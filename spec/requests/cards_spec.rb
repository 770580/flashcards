require 'rails_helper'

describe "Card pages" do
  let!(:card) { FactoryGirl.create(:card) }
  before do
    visit root_path
  end

  it "when check passed should have message Верно" do
    visit root_path
    fill_in "flash_card[input_text]", with: "Dog"
    click_button "Проверить"
    expect(page).to have_selector('p', text: "Верно")
  end

  it "when check not passed should have message Ошибка" do
    fill_in "flash_card[input_text]", with: "Cat"
    click_button "Проверить"
    expect(page).to have_selector('p', text: "Ошибка")
  end
end
