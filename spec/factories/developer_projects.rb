# == Schema Information
#
# Table name: developer_projects
#
#  id           :bigint           not null, primary key
#  current      :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  developer_id :bigint           not null
#  project_id   :bigint           not null
#
# Indexes
#
#  index_developer_projects_on_developer_id  (developer_id)
#  index_developer_projects_on_project_id    (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (developer_id => developers.id)
#  fk_rails_...  (project_id => projects.id)
#
FactoryBot.define do
  factory :developer_project do
    developer { nil }
    project { nil }
  end
end
