# == Schema Information
#
# Table name: developer_teches
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  developer_id :bigint           not null
#  tech_id      :bigint           not null
#
# Indexes
#
#  index_developer_teches_on_developer_id  (developer_id)
#  index_developer_teches_on_tech_id       (tech_id)
#
# Foreign Keys
#
#  fk_rails_...  (developer_id => developers.id)
#  fk_rails_...  (tech_id => teches.id)
#
class DeveloperTech < ApplicationRecord
  belongs_to :developer
  belongs_to :tech
end
