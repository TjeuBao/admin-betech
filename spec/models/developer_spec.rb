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

  describe 'assocation' do
    it { is_expected.to have_many(:projects).through(:developer_projects) }
    it { is_expected.to have_many(:teches).through(:developer_teches) }
    it{ should accept_nested_attributes_for :developer_projects }
  end
end
