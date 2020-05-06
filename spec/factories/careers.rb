# == Schema Information
#
# Table name: careers
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  jobtype    :string           not null
#  status     :string           not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :career do
    title { "" }
    content { "" }
    jobtype { "" }
    status { "MyString" }
  end
end
