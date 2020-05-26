# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.html_safe
end

ActionMailer::Base.smtp_settings = {
  :user_name => "chrisyqwe123",
  :password => "19960730-Chris",
  :domain => "heroku.com",
  :address => "smtp.sendgrid.net",
  :port => "465",
  :authentication => :plain,
  :enable_starttls_auto => true,
}
