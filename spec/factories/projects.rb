# == Schema Information
#
# Table name: projects
#
#  id               :bigint           not null, primary key
#  deployment       :string
#  description      :string           not null
#  development_type :integer
#  end_date         :date
#  git_repo         :string
#  industry         :integer
#  name             :string           not null
#  start_date       :date
#  trello           :string
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
FactoryBot.define do
  factory :project do
    name { "MyString" }
    description { "MyString" }
    start_date { Date.today }
    end_date { Date.today }
    deployment { "MyString" }
    website { "MyString" }
  end
end
