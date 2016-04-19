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
    fill_in I18n.t('cards.origin_text_label'), with: "doggy"
    click_button I18n.t('form_submit.check')
    expect(page).to have_content("Ошибка")
  end

  it "when check has misprint should have message Опечатка" do
    fill_in I18n.t('cards.origin_text_label'), with: "dor"
    click_button I18n.t('form_submit.check')
    expect(page).to have_content("Опечатка. Ваш ответ dor, а правильный Dog. Перевод Собака")
  end
end
