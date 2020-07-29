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
FactoryBot.define do
  factory :subscription do
    name { 'mystring' }
    email { 'mystring@gmail.com' }
    subscription_type { 'both' }
  end

  trait :invalid_subscription do
    name { '' }
    email { '' }
    subscription_type { '' }
  end
end
