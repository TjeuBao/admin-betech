# == Schema Information
#
# Table name: job_submissions
#
#  id         :bigint           not null, primary key
#  answer     :text
#  email      :string           not null
#  first_name :string           not null
#  last_name  :string           not null
#  port_folio :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  career_id  :integer
#
# Foreign Keys
#
#  fk_rails_...  (career_id => careers.id)
#
class JobSubmissionSerializer
  include FastJsonapi::ObjectSerializer
  attributes  :first_name,
              :last_name,
              :email,
              :port_folio,
              :answer
end
