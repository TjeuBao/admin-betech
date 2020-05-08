# == Schema Information
#
# Table name: careers
#
#  id                 :bigint           not null, primary key
#  image_content_type :string
#  image_file_name    :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  jobtype            :string           not null
#  status             :string           not null
#  title              :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
FactoryBot.define do
  factory :career do
    title { "" }
    content { "" }
    jobtype { "" }
    status { "MyString" }
  end
end
