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
# Indexes
#
#  index_projects_on_name  (name) UNIQUE
#
class Project < ApplicationRecord
  has_and_belongs_to_many :teches
  has_and_belongs_to_many :developers
  has_one_attached :image
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
