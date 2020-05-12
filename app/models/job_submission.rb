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
  has_attached_file :cv_upload, styles: { thumbnail: '60x60#' },
                                storage: :cloudinary,
                                path: ':id/:style/:filename'
  validates_attachment :cv_upload, content_type: { content_type: 'application/pdf' }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
end
