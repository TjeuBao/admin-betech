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

  scope :with_teches, ->(params) { where('tech_id = ?', params) }
  scope :not_have_current_project, -> { where('developer_projects.current IS NULL') }

  def self.free_after_x_days(params)
    available_developer = []
    Developer.all.each do |developer|
      current = developer.developer_projects.where('current = true')

      max_end_date = find_max_end_date(current, 0, current[0].project.end_date)
      available_developer.push(developer) if max_end_date <= Date.today + params
    end
    Developer.where(id: available_developer.pluck(:id))
  end

  def self.find_max_end_date(current, index, max)
    while index < current.count
      b = current[index].project.end_date
      if max > b
        max
      elsif max < b
        max = b
      end
      index += 1
    end
    max
  end
end
