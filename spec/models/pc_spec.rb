# == Schema Information
#
# Table name: pcs
#
#  id           :bigint           not null, primary key
#  company_name :string           not null
#  full_name    :string           not null
#  level        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe Pc, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of :full_name }
    it { is_expected.to validate_presence_of :company_name }
    it { is_expected.to validate_presence_of :level }
  end

  describe 'association' do
    it { is_expected.to have_many(:projects).through(:pc_projects) }
    it { should accept_nested_attributes_for :pc_projects }
  end
end
