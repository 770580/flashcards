include ApplicationHelper
def user_login(user, password = "asdf")
  visit login_path
  fill_in "Email", with: user.email
  fill_in "password", with: password
  click_button I18n.t('user_sessions.sign_in')
end
