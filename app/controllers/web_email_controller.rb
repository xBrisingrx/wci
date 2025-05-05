class WebEmailController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :no_login

  def contact_email
    ContactMailer.with(name: email_params[:name], email: email_params[:email]).contact_email.deliver_later
    render json: {data: email_params, status: 'success'}
  end

  private
  def email_params
    params.require(:data).permit(:name, :email, :country, :city, :company, :comment, :courses)
  end
end
