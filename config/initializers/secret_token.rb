# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.

if Rails.env.test? || Rails.env.development? || Rails.env == "profile"
  RailsUsefulLink::Application.config.secret_token = "7ab148a821ef651678105048552f246848efa2add3a23ece510085a183f4044475258dd5d5ce1fb3bf28c871b1d924b4d9d48f38138726ec1c8d8d2c053d9f25"
else
  raise "You must set a secret token in ENV['SECRET_TOKEN'] or in config/initializers/secret_token.rb" if ENV['SECRET_TOKEN'].blank?
  RailsUsefulLink::Application.config.secret_token = ENV['SECRET_TOKEN']
end