class WebEmailController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :no_login

  def contact_email
    ContactMailer.with(params: " ====").contact_email.deliver_later
  end
end
