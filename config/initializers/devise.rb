Devise.setup do |config|
  config.secret_key = ENV['SECRET_KEY'] || ('x' * 30)

  config.omniauth :github, ENV['GITHUB_ID'], ENV['GITHUB_SECRET']

  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'

  config.authentication_keys = [ :login ]

  config.case_insensitive_keys = [ :email ]

  config.strip_whitespace_keys = [ :email ]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 10

  config.reconfirmable = true

  config.password_length = 8..128

  config.reset_password_within = 6.hours

  config.sign_out_via = :delete
end
