# == Schema Information
#
# Table name: subscriptions
#
#  id                :bigint           not null, primary key
#  email             :string           not null
#  name              :string
#  subscription_type :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Subscription < ApplicationRecord
  after_create_commit :send_mail

  SUBSCRIPTION_TYPE = %w[both post career].freeze

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  # validates :name, presence: true
  validates :subscription_type,
            inclusion: { in: SUBSCRIPTION_TYPE }
  validates :email,
            format: { with: VALID_EMAIL_REGEX },
            presence: true,
            uniqueness: { scope: :subscription_type }

  scope :list_email_subscription_posts, lambda {
    where(subscription_type: %w[both post])
  }
  scope :list_email_subscription_careers, lambda {
    where(subscription_type: %w[both career])
  }

  def user_name
    email.split('@')[0]
  end

  private

  def send_mail
    SubscriptionMailer.subscribe_email_successfull(email, id).deliver_later
  end
end
