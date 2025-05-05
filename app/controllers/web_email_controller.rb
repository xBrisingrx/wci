class WebEmailController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :no_login

  def contact_email
    ContactMailer.with(params: params[:data]).contact_email.deliver_later
    render json: {data: params[:data], status: 'success'}
  end
end
