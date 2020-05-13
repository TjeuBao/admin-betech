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
class JobSubmission < ApplicationRecord
  belongs_to :career
  has_attached_file :cv_upload, storage: :cloudinary

  # validates_attachment_content_type :cv_upload, content_type: ['application/pdf', 'application/docx']
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
end
