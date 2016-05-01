include ApplicationHelper
def user_login(user, password = "asdf")
  visit home_login_path
  fill_in I18n.t('user_sessions.email'), with: user.email
  fill_in I18n.t('user_sessions.pass_label'), with: password
  click_button I18n.t('user_sessions.sign_in')
end
