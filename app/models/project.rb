# == Schema Information
#
# Table name: projects
#
#  id               :bigint           not null, primary key
#  deployment       :string
#  description      :string           not null
#  development_type :integer
#  end_date         :date
#  name             :string           not null
#  start_date       :date
#  website          :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  client_id        :bigint
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
  enum development_type: { mobile: 0, website: 1 }
  has_and_belongs_to_many :teches
  has_many :developer_projects
  has_many :developers, through: :developer_projects
  belongs_to :client
  has_one_attached :image
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :deployment, presence: true

  scope :search, ->(search_string) { where('lower(name) LIKE ? OR lower(deployment) LIKE ?', "%#{search_string.downcase}%", "%#{search_string.downcase}%") }
end
