include ApplicationHelper
def user_login(user , password = "asdf")
  visit login_path
  fill_in "email", with: user.email
  fill_in "password", with: password
  click_button "Войти"
end