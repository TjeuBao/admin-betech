# == Schema Information
#
# Table name: teches
#
#  id         :bigint           not null, primary key
#  name       :string
#  tech_type  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tech < ApplicationRecord
  TECH_TYPES = %w[frontend backend db].freeze
  enum tech_type: TECH_TYPES.zip(TECH_TYPES.map(&:titleize)).to_h
  has_and_belongs_to_many :projects
  validates :name, presence: true, uniqueness: true
end
