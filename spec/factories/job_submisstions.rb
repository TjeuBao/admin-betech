# == Schema Information
#
# Table name: job_submisstions
#
#  id         :bigint           not null, primary key
#  answer     :text
#  email      :string
#  first_name :string
#  last_name  :string
#  port_folio :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  career_id  :integer
#
FactoryBot.define do
  factory :job_submisstion do
    first_name { "MyString" }
    last_name { "MyString" }
    email { "MyString" }
    port_folio { "MyString" }
    answer { "MyText" }
    cv_upload { nil }
    career_id { "" }
  end
end
