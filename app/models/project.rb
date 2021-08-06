# == Schema Information
#
# Table name: projects
#
#  id          :bigint           not null, primary key
#  deployment  :string
#  description :string           not null
#  end_date    :date
#  git_repo    :string
#  industry    :integer
#  name        :string           not null
#  start_date  :date
#  trello      :string
#  website     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  client_id   :bigint
#
# Indexes
#
#  index_projects_on_client_id  (client_id)
#  index_projects_on_name       (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#
class Project < ApplicationRecord
  DAYS_FROM_NOW = [10, 30, 60].freeze
  enum industry: { sport: 0, ecommerce: 1, finance: 2, education: 3, manufacturing: 4, medical: 5, health_fitness: 6 }

  has_and_belongs_to_many :teches
  has_and_belongs_to_many :development_types
  has_many :developer_projects, dependent: :destroy
  has_many :developers, through: :developer_projects
  has_many :pc_projects, dependent: :destroy
  has_many :pcs, through: :pc_projects
  has_one_attached :image
  belongs_to :client

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :deployment, presence: true

  scope :filter_development_type, ->(development_type_ids) { where('development_type_id = ?', development_type_ids) }
  scope :filter_industry, ->(industry) { where('industry = ?', industry) }
  scope :search, ->(query) { where('lower(name) LIKE ? OR lower(deployment) LIKE ?', "%#{query.downcase}%", "%#{query.downcase}%") }
end
