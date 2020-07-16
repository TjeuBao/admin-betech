# == Schema Information
#
# Table name: careers
#
#  id                 :bigint           not null, primary key
#  image_content_type :string
#  image_file_name    :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  job_type           :string
#  slug               :string
#  status             :string
#  title              :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_careers_on_slug  (slug) UNIQUE
#
FactoryBot.define do
  factory :career do
    title { 'Developer' }
    content { 'Content' }
    job_type { Career::JOB.sample }
    status { Career::STATUSES.sample }
  end
  trait :empty do
    title { '' }
    content { '' }
    job_type { '' }
    status { '' }
  end
end
