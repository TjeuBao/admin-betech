# == Schema Information
#
# Table name: subscribes
#
#  id             :bigint           not null, primary key
#  email          :string           not null
#  name           :string           not null
#  subscribe_type :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
  factory :subscribe do
    name { 'MyString' }
    email { 'MyString' }
    subscribe_type { 'MyString' }
  end
  trait :invalid_subscribe do
    name { '' }
    email { '' }
    subscribe_type { '' }
  end
end
