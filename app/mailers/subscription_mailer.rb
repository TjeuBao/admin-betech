class SubscriptionMailer < ApplicationMailer
  default from: 'austin@goldenowl.asia'

  def email_subscription(list_email)
    mail(to: list_email, subject: 'Subscription Email') if list_email.any?
  end
end
