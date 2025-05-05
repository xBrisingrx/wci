class ContactMailer < ApplicationMailer
  default from: "soporte@maurosampaoli.com.ar"

  def contact_email # este email nos lo envian desde la web de webcontroll.la
    @name = params[:name]
    @email = params[:email]
    mail(to: @email, subject: "Mensaje desde formulario Sitio wellcontrol.la")
  end
end
