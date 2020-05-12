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
class JobSubmisstion < ApplicationRecord
  belongs_to :career
  has_attached_file :cv_upload, storage: :cloudinary,
                                path: ':id/:style/:filename', presence: true
  validates_attachment_content_type :cv_upload,
                                    content_type: ['file/pdf', 'file/doc', 'file/docx']
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
end
