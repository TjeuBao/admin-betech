# == Schema Information
#
# Table name: projects
#
#  id          :bigint           not null, primary key
#  description :string           not null
#  end_date    :date
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_projects_on_name  (name) UNIQUE
#
class Project < ApplicationRecord
  DAYS_FROM_NOW = [10, 30, 60].freeze
  has_and_belongs_to_many :teches
  has_many :developer_projects
  has_many :developers, through: :developer_projects
  has_one_attached :image
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
