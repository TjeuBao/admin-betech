# == Schema Information
#
# Table name: projects
#
#  id          :bigint           not null, primary key
#  description :string           not null
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Project < ApplicationRecord
  has_and_belongs_to_many :teches
  has_and_belongs_to_many :developers
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true
end
