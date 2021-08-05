# == Schema Information
#
# Table name: development_types
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :development_type do
    name { "MyString" }
  end
end
