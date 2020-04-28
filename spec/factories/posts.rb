# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :post do
    title { 'MyString' }
    content { 'MyText' }
  end
  trait :invalid do
    title { '' }
    content { '' }
  end
end
