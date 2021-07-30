# == Schema Information
#
# Table name: clients
#
#  id         :bigint           not null, primary key
#  address    :string
#  hq         :string
#  latitude   :float
#  longitude  :float
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Client < ApplicationRecord
  geocoded_by :address
  after_validation :geocode
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :hq, presence: true
  has_many :projects

  scope :search, ->(search_string) { where('lower(name) LIKE ? OR lower(hq) LIKE ?', "%#{search_string.downcase}%", "%#{search_string.downcase}%") }
end
