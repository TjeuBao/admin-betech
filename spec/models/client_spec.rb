# == Schema Information
#
# Table name: clients
#
#  id          :bigint           not null, primary key
#  address     :string
#  hq          :string
#  latitude    :float
#  longitude   :float
#  name        :string
#  nationality :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :address }
    it { is_expected.to validate_presence_of :hq }
  end
  
  describe 'assocation' do
    it { is_expected.to have_many(:projects) }
  end
end
