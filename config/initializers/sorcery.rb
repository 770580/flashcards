# The first thing you need to configure is which modules you need in your app.
# The default is nothing which will include only core features (password encryption, login/logout).
# Available submodules are: :user_activation, :http_basic_auth, :remember_me,
# :reset_password, :session_timeout, :brute_force_protection, :activity_logging, :external
Rails.application.config.sorcery.submodules = [:external]

# Here you can configure each submodule's features.
Rails.application.config.sorcery.configure do |config|
  # -- external --
  # What providers are supported by this app, i.e. [:twitter, :facebook, :github, :linkedin, :xing, :google, :liveid, :salesforce] .
  # Default: `[]`
  #
  config.external_providers = [:facebook]

  config.facebook.key = ENV["SORCERY_FACEBOOK_KEY"]
  config.facebook.secret = ENV["SORCERY_FACEBOOK_SECRET"]
  config.facebook.callback_url = ENV["SORCERY_FACEBOOK_CALLBACK_URL"]
  config.facebook.user_info_mapping = { :email => "name" }
  config.facebook.access_permissions = ["email"]
  config.facebook.display = "popup"
  config.facebook.api_version = "v2.2"

  # --- user config ---
  config.user_config do |user|
    user.authentications_class = Authentication
  end

  # This line must come after the 'user config' block.
  # Define which model authenticates with sorcery.
  config.user_class = "User"
end
