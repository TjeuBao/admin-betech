# == Schema Information
#
# Table name: job_submisstions
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

RSpec.describe JobSubmisstion, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
