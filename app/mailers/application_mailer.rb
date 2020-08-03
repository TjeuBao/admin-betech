# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  layout 'mailer'
  default from: "Golden Owl <#{ENV['MAIL_ADMIN_SENDER']}>"

  def reset_password_instructions(user_email)
    mail(to: user_email, subject: 'Forget Password Email') if user_email.any?
  end
end
