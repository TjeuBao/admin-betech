# == Schema Information
#
# Table name: careers
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  jobtype    :string           not null
#  status     :string           not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Career, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
