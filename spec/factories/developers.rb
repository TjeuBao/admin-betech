# == Schema Information
#
# Table name: developers
#
#  id         :bigint           not null, primary key
#  infomation :string
#  level      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :developer do
    infomation { "MyString" }
    level { "MyString" }
  end
end
