# == Schema Information
#
# Table name: subscribes
#
#  id             :bigint           not null, primary key
#  email          :string           not null
#  name           :string           not null
#  subscribe_type :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'rails_helper'

RSpec.describe Subscribe, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :subscribe_type }
  end
end
