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
class Career < ApplicationRecord
  validates :content, presence: true
  validates :title, presence: true
  validates :jobtype, presence: true
  validates :status, presence: true
end
