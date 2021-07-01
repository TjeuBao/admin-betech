# == Schema Information
#
# Table name: developers
#
#  id         :bigint           not null, primary key
#  infomation :string
#  level      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Developer, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of :infomation }
    it { is_expected.to validate_presence_of :level }
  end

  describe 'assocation' do
    it { is_expected.to have_and_belong_to_many(:projects) }
  end
end
