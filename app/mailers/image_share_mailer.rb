class ImageShareMailer < ApplicationMailer
  default from: "chrisiseatinglol@gmail.com"

  def welcome_email(image, email, message)
    @image = image
    @email = email
    @message = message
    @url = "https://eating-image.herokuapp.com/"
    mail(to: @email, subject: "welcome to My awesome site!!")
  end
end
