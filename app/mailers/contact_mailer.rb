class ContactMailer < ApplicationMailer
  default from: "soporte@maurosampaoli.com.ar"

  def contact_email # este email nos lo envian desde la web de webcontroll.la
    # @email = params[:email]
    @name = params[:name]
    @email = params[:email]
    @params = params[:email]
    mail(to: params[:email], subject: "Mensaje desde formulario Sitio wellcontrol.la")
  end
end
