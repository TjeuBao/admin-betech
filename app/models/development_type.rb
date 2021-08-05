# == Schema Information
#
# Table name: development_types
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class DevelopmentType < ApplicationRecord
  has_and_belongs_to_many :projects

  validates :name, uniqueness: true
end
