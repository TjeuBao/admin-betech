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
#Subscribe
class Subscribe < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :subscribe_type, presence: true
end
