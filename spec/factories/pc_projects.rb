# == Schema Information
#
# Table name: pc_projects
#
#  id         :bigint           not null, primary key
#  join_date  :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  pc_id      :bigint           not null
#  project_id :bigint           not null
#
# Indexes
#
#  index_pc_projects_on_pc_id       (pc_id)
#  index_pc_projects_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (pc_id => pcs.id)
#  fk_rails_...  (project_id => projects.id)
#
FactoryBot.define do
  factory :pc_project do
    join_date { "2021-07-28" }
    pc { nil }
    project { nil }
  end
end
