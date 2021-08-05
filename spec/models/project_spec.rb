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
require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_presence_of :start_date }
    it { is_expected.to validate_presence_of :end_date }
    it { is_expected.to validate_presence_of :deployment }
  end

  describe 'assocation' do
    it { is_expected.to have_and_belong_to_many(:teches) }
    it { is_expected.to have_many(:developers) }
    it { is_expected.to belong_to(:client) }
  end
end
