# == Schema Information
#
# Table name: developers
#
#  id           :bigint           not null, primary key
#  belong_team  :string
#  company_name :string
#  full_name    :string
#  level        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_developers_on_company_name  (company_name) UNIQUE
#  index_developers_on_full_name     (full_name) UNIQUE
#
class Developer < ApplicationRecord
  has_many :developer_projects
  has_many :projects, through: :developer_projects
  has_many :developer_teches
  has_many :teches, through: :developer_teches
  accepts_nested_attributes_for :developer_projects, allow_destroy: true
  validates :full_name, presence: true, uniqueness: true
  validates :company_name, presence: true, uniqueness: true
  validates :belong_team, presence: true
  validates :level, presence: true

  scope :filter_developer, ->(params) { where('tech_id = ?', params) }
  scope :filter_current, -> { where('developer_projects.current IS NULL') }

  def self.filter_day(params)
    available_developer = []
    current = Developer.joins(:developer_projects).where('developer_projects.current = true')
    Developer.all.each do |developer|
      end_date = developer.projects.maximum(:end_date)
      available_developer.push(developer) if end_date <= Date.today + params
    end
    available_developer &= current
    Developer.where(id: available_developer.pluck(:id))
  end
end
