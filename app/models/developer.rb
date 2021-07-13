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

  def self.filter_developer(params)
    where('tech_id = ?', params)
  end

  def self.filter_day(params)
    where('projects.end_date <= ? AND developer_projects.current = ?', Date.today + params, true)
  end

  def self.filter_current
    where('developer_projects.current IS NULL')
  end
end
