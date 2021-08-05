# == Schema Information
#
# Table name: development_types
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe DevelopmentType, type: :model do
  describe 'validates' do
    it { is_expected.to validate_uniqueness_of :name }
  end

  describe 'assocation' do
    it { is_expected.to have_and_belong_to_many(:projects) }
  end
end
