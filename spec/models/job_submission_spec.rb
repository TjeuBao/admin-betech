# == Schema Information
#
# Table name: job_submissions
#
#  id         :bigint           not null, primary key
#  answer     :text
#  email      :string
#  first_name :string
#  last_name  :string
#  port_folio :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  career_id  :integer
#
require 'rails_helper'

RSpec.describe JobSubmission, type: :model do
  context 'validetess' do
    it { is_expected.to validate_presence_of :first_name }
  end
  context 'validates' do
    it { is_expected.to validate_presence_of :last_name }
  end
  context 'validates' do
    it { is_expected.to validate_presence_of :email }
  end
  context 'validates' do
    it { is_expected.to validate_presence_of :cv_upload }
  end
end
