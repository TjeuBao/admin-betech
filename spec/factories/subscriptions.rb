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
FactoryBot.define do
  factory :subscription do
    name { 'MyString' }
    email { 'MyString@gmail.com' }
    subscription_type { 'MyString' }
  end
  trait :invalid_subscription do
    name { '' }
    email { '' }
    subscription_type { '' }
  end
end
