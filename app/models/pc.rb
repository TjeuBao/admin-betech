# == Schema Information
#
# Table name: pcs
#
#  id           :bigint           not null, primary key
#  company_name :string           not null
#  full_name    :string           not null
#  level        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Pc < ApplicationRecord
  has_many :pc_projects
  has_many :projects, through: :pc_projects
  accepts_nested_attributes_for :pc_projects, allow_destroy: true
  validates :full_name, presence: true, uniqueness: true
  validates :company_name, presence: true, uniqueness: true
  validates :level, presence: true
end
