# == Schema Information
#
# Table name: developers
#
#  id         :bigint           not null, primary key
#  infomation :string
#  level      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Developer < ApplicationRecord
  has_and_belongs_to_many :projects
  validates :infomation, presence: true, uniqueness: true
  validates :level, presence: true
end
