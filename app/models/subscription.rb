# == Schema Information
#
# Table name: subscriptions
#
#  id                :bigint           not null, primary key
#  email             :string           not null
#  name              :string           not null
#  subscription_type :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Subscription < ApplicationRecord
  after_create :send_mail_to_subscription
  validates :name, presence: true
  validates :email, presence: true

  private
  def send_mail_to_subscription
    @subscription_email = Subscription.email if Subscription.subscription.type = nil
		@subscription_email_post = Subscription.email if Subscription.subscription.type = post
    @subscription_email_career = Subscription.email if Subscription.subscription.type = career

    @post.create! => send mail to @subscription_email_post && send mail to subcription_email
		@career.create!  => send mail to   @subscription_email_career && send mail to subcription_email
  end
end
