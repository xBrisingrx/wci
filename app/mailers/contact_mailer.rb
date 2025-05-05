class ContactMailer < ApplicationMailer
  default from: "soporte@maurosampaoli.com.ar"

  def contact_email(name, email) # este email nos lo envian desde la web de webcontroll.la
    # @email = params[:email]
    @name = name
    @params = params
    mail(to: email, subject: "Mensaje desde formulario Sitio wellcontrol.la")
  end
end
