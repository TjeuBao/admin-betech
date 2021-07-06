# == Schema Information
#
# Table name: teches
#
#  id         :bigint           not null, primary key
#  name       :string
#  tech_type  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Tech, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of :name }
    it do
      should define_enum_for(:tech_type)
        .with_values(
          frontend: 'Frontend',
          backend: 'Backend',
          db: 'Db'
        )
        .backed_by_column_of_type(:string)
    end
  end
  
  describe 'assocation' do
    it { is_expected.to have_and_belong_to_many(:projects) }
  end
end
