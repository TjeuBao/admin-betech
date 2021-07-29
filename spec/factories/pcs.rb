# == Schema Information
#
# Table name: pcs
#
#  id           :bigint           not null, primary key
#  company_name :string           not null
#  full_name    :string           not null
#  level        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
FactoryBot.define do
  factory :pc do
    full_name { "MyString" }
    company_name { "MyString" }
    level { "MyString" }
  end
end
