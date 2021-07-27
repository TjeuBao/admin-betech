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
require 'rails_helper'

RSpec.describe Developer, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of :full_name }
    it { is_expected.to validate_presence_of :company_name }
    it { is_expected.to validate_presence_of :belong_team }
    it { is_expected.to validate_presence_of :level }
  end

  describe 'association' do
    it { is_expected.to have_many(:projects).through(:developer_projects) }
    it { is_expected.to have_many(:teches).through(:developer_teches) }
    it { should accept_nested_attributes_for :developer_projects }
  end
  
  describe 'not_have_current_project' do
    let(:client) { FactoryBot.create(:client) }
    let(:project) { FactoryBot.create(:project, client_id: client.id) }
    let(:developer) { FactoryBot.create(:developer, project_ids: project.id) }
    let(:developer_project) { FactoryBot.create(:developer_project, developer_id: developer.id, project_id: project.id) }
    it {
      expect(Developer.joins(:projects).not_have_current_project).to include(developer_project.developer)
    }
  end

  describe 'with_teches' do
    let(:tech)  { FactoryBot.create(:tech, tech_type: 'frontend') }
    let(:developer) { FactoryBot.create(:developer, tech_ids: tech.id) }
    let(:developer_tech) { FactoryBot.create(:developer_tech, developer_id: developer.id, tech_id: tech.id) }
    it {
      expect(Developer.joins(:teches).with_teches(tech.id)).to include(developer_tech.developer)
    }
  end

  describe 'free_after_x_days' do
    let(:client) { FactoryBot.create(:client) }
    let(:project) { FactoryBot.create(:project, client_id: client.id) }
    let(:developer) { FactoryBot.create(:developer, project_ids: project.id) }
    let(:developer_project) { FactoryBot.create(:developer_project, developer_id: developer.id, project_id: project.id, current: true) }
    it {
      developer_project
      expect(Developer.joins(:projects).free_after_x_days(Project::DAYS_FROM_NOW[0].to_d)).to include(developer_project.developer)
    }
  end
end
