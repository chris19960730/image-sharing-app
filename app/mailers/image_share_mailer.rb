class ImageShareMailer < ApplicationMailer
  default from: "390074138chris@gmail.com"

  def welcome_email
    @image = params[:image]
    @email = params[:email]
    @url = "https://getbootstrap.com/docs/4.4/content/images/"
    mail(to: @email, subject: "welcome to My awesome site!!")
  end
end
