# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.html_safe
end

# ActionMailer::Base.smtp_settings = {
#   :user_name => "api_key",
#   :password => ENV["SENDGRID_API_KEY"],
#   :domain => "heroku.com",
#   :address => "smtp.sendgrid.net",
#   :port => "465",
#   :authentication => :plain,
#   :enable_starttls_auto => true,
# }
