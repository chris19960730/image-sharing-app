class ImageShareMailer < ApplicationMailer
  default from: "chrisiseatinglol@gmail.com"

  def welcome_email(image, email)
    @image = image
    @email = email
    @url = "https://eating-image.herokuapp.com/"
    mail(to: @email, subject: "welcome to My awesome site!!")
  end
end
