require 'rails_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }
  before { visit root_path }
  describe "Registration" do
    before { click_link I18n.t('navbar.sign_up') }

    it "should not create user with invalid parameters" do
      expect { click_button I18n.t('form_submit.new') }.not_to change(User, :count)
    end

    it "should create user with valid parameters" do
      fill_in "Email", with: "user@user.ru"
      fill_in I18n.t('users.pass_label'), with: "asdf"
      fill_in I18n.t('users.pass_confirm_label'), with: "asdf"
      expect { click_button I18n.t('form_submit.new') }.to change(User, :count).by(1)
    end
  end

  describe "Login" do
    it "should be login page on index" do
      expect(page).to have_content("Войти")
    end

    it "should be successful login" do
      click_link I18n.t('navbar.sign_in')
      user_login user
      expect(page).to have_content(user.email)
    end

    it "should be failed with incorrect password" do
      click_link I18n.t('navbar.sign_in')
      user_login(user, " ")
      expect(page).to have_content("Ошибка в email или пароле")
    end
  end

  it "should be logout" do
    user_login user
    click_link I18n.t('navbar.exit')
    expect(page).to have_content("Войти")
  end
end
