# == Schema Information
#
# Table name: post_categories
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
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

  acts_as_paranoid

  friendly_id :title, use: :slugged

  validates :title, presence: true, uniqueness: true

  has_many :posts

  before_destroy :delete_posts

  private

  def delete_posts
    posts.update_all(deleted: true)
  end
end
