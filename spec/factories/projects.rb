# == Schema Information
#
# Table name: projects
#
#  id          :bigint           not null, primary key
#  description :string           not null
#  end_date    :date
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_projects_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :project do
    name { "MyString" }
    description { "MyString" }
    techstack { "MyString" }
  end
end
