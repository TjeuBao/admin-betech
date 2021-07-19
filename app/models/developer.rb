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
      if current.present?
        n = 0
        end_date = Date.today
        max = current[0].project.end_date
        while n < current.count
          b = current[n].project.end_date
          if max > b
            max
          elsif max < b
            max = b
          end 
          n += 1
        end
        end_date = max
        available_developer.push(developer) if end_date <= Date.today + params
      end
    end
    Developer.where(id: available_developer.pluck(:id))
  end
end
