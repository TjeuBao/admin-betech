# == Schema Information
#
# Table name: developers
#
#  id           :bigint           not null, primary key
#  belong_team  :string
#  company_name :string
#  full_name    :string
#  level        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_developers_on_company_name  (company_name) UNIQUE
#  index_developers_on_full_name     (full_name) UNIQUE
#
FactoryBot.define do
  factory :developer do
    information { "MyString" }
    level { "MyString" }
  end
end
