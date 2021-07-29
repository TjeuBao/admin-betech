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
  pending "add some examples to (or delete) #{__FILE__}"
end
