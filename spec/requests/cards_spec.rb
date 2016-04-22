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
    fill_in I18n.t('cards.origin_text_label'), with: "dog"
    click_button I18n.t('form_submit.check')
    expect(page).to have_content("Верно")
  end

  it "when check not passed should have message Ошибка" do
    fill_in I18n.t('cards.origin_text_label'), with: "doggggg"
    click_button I18n.t('form_submit.check')
    expect(page).to have_content("Ошибка")
  end

  it "when check has 1 misprint should have message Опечатка" do
    fill_in I18n.t('cards.origin_text_label'), with: "dogg"
    click_button I18n.t('form_submit.check')
    expect(page).to have_content("Опечатка. Ваш ответ dogg, а правильный Dog. Перевод Собака")
  end

  it "when check has 2 misprint should have message Опечатка" do
    fill_in I18n.t('cards.origin_text_label'), with: "doggg"
    click_button I18n.t('form_submit.check')
    expect(page).to have_content("Опечатка. Ваш ответ doggg, а правильный Dog. Перевод Собака")
  end

  it "when check has 3 misprint should have message Опечатка" do
    fill_in I18n.t('cards.origin_text_label'), with: "dogggg"
    click_button I18n.t('form_submit.check')
    expect(page).to have_content("Опечатка. Ваш ответ dogggg, а правильный Dog. Перевод Собака")
  end
end
