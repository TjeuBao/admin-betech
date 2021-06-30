# == Schema Information
#
# Table name: teches
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Tech, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of :name }
  end
end
