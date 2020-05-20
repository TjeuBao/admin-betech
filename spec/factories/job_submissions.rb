# == Schema Information
#
# Table name: job_submissions
#
#  id                     :bigint           not null, primary key
#  answer                 :text
#  cv_upload_content_type :string
#  cv_upload_file_name    :string
#  cv_upload_file_size    :integer
#  cv_upload_updated_at   :datetime
#  email                  :string           not null
#  first_name             :string           not null
#  last_name              :string           not null
#  port_folio             :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  career_id              :integer
#
# Foreign Keys
#
#  fk_rails_...  (career_id => careers.id)
#
FactoryBot.define do
  factory :job_submission do
    first_name { 'MyString' }
    last_name { 'MyString' }
    email { 'MyString' }
    port_folio { 'MyString' }
    answer { 'MyText' }
    career { FactoryBot.create(:career) }
  end
  trait :invaid_job_submission do
    first_name { '' }
    last_name { '' }
    email { '' }
    port_folio { '' }
    answer { '' }
    career_id { '' }
  end
end
