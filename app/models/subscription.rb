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
  validates :name, presence: true
  validates :email, presence: true
  scope :email_subscription_post, -> { where("subscription_type IS NULL or  subscription_type = '' or subscription_type = 'post'") }
  scope :email_subscription_career, -> { where("subscription_type IS NULL or  subscription_type = '' or subscription_type = 'career'") }
end
