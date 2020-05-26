class SubscriptionMailer < ApplicationMailer
  default from: 'from@example.com'

  def email_subscription(list_email)
    mail to: list_email, subject: 'Sample Email'
  end
end
