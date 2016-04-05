require 'rails_helper'

describe User do
  
  let(:user) { FactoryGirl.create(:user)}
  before { visit root_path }
  describe "Registration" do
    before { click_link "Регистрация" }

    it "should not create user with invalid parameters" do
      expect { click_button "Создать" }.not_to change(User, :count)
    end

    it "should create user with valid parameters" do
      fill_in "Email", with: "user@user.ru"
      fill_in "Пароль", with: "asdf"
      fill_in "Пароль еще раз", with: "asdf"
      expect { click_button "Создать" }.to change(User, :count).by(1)
    end
  end

  describe "Login" do
    it "should be login page on index" do
      expect(page).to have_content("Войти")
    end

    it "should be successful login" do
      click_link "Вход"
      user_login user
      expect(page).to have_content("Login successful")
    end

    it "should be failed with incorrext password" do
      click_link "Вход"
      user_login(user, " ")
      expect(page).to have_content("Login failed")
    end
  end

  it "should be logout" do
    user_login user
    click_link "Выход"
    expect(page).to have_content("Войти")
  end
end
