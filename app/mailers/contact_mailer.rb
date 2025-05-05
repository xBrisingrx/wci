class ContactMailer < ApplicationMailer
  default from: ENV["EMAIL_FROM"]

  def contact_email # este email nos lo envian desde la web de webcontroll.la
    @name = params[:name]
    @email = params[:email]
    @phone = params[:phone]
    @company = params[:company]
    @courses = params[:courses].split("$")
    @courses.shift
    @country = params[:country]
    @city = params[:city]
    @comment = params[:comment]
    mail(to: ENV["EMAIL_TO"], subject: "Mensaje desde formulario Sitio wellcontrol.la")
  end
end
