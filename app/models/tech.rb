# == Schema Information
#
# Table name: teches
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tech < ApplicationRecord
  has_and_belongs_to_many :projects
  validates :name, presence: true, uniqueness: true
end
