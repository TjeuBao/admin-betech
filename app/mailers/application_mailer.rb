# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'austin@goldenowl.asia'
  layout 'mailer'

  def reset_password_instructions(user_email)
    mail(to: user_email, subject: 'Forget Password Email') if user_email.any?
  end
end
