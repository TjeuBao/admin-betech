class SubscriptionMailer < ApplicationMailer
  helper MailerHelper

  default from: ENV['MAIL_ADMIN_SENDER']

  def subscription_email_for_post(email, post_id = nil)
    @post = Post.find_by(id: post_id)
    return if email.nil? || @post.nil?

    mail(to: email, subject: 'Subscription Email')
  end

  def subscription_email_for_career(email, career_id = nil)
    @career = Career.find_by(id: career_id)
    return if email.nil? || @career.nil?

    mail(to: email, subject: 'Subscription Email')
  end

  def subscribe_email_successfull(email, subscription_id = nil)
    @subscription = Subscription.find_by(id: subscription_id)
    return if email.nil? || @subscription.nil?

    mail(to: email, subject: 'GOLDEN OWL - SUCCESS SUBSCRIPTION')
  end
end
