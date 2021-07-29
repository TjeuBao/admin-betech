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
class PcProject < ApplicationRecord
  belongs_to :pc
  belongs_to :project
end
