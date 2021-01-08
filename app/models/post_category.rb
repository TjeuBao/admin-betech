# == Schema Information
#
# Table name: post_categories
#
#  id         :bigint           not null, primary key
#  slug       :string
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_post_categories_on_slug  (slug) UNIQUE
#
class PostCategory < ApplicationRecord
  extend FriendlyId

  friendly_id :title, use: :slugged

  validates :title, presence: true, uniqueness: true

  has_many :posts, dependent: :destroy
end
