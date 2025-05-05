class ContactMailer < ApplicationMailer
  default from: "notifications@example.com"

  def contact_email # este email nos lo envian desde la web de webcontroll.la
    puts params
  end
end
