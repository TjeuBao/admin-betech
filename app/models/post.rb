# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id                 :bigint           not null, primary key
#  deleted            :boolean          default(FALSE)
#  image_content_type :string
#  image_file_name    :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  meta_description   :string
#  meta_keyword       :string
#  meta_title         :string
#  post_type          :string
#  slug               :string
#  source             :string
#  title              :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  post_category_id   :bigint
#
# Indexes
#
#  index_posts_on_post_category_id  (post_category_id)
#  index_posts_on_slug              (slug) UNIQUE
#
class Post < ApplicationRecord
  extend FriendlyId
  include ConvertImageUrl
  has_many_attached :content

  friendly_id :title, use: :slugged

  after_create_commit :send_mail

  has_rich_text :content

  has_attached_file :image, preserve_files: true, styles: { medium: '300x300>', thumb: '100x100>' }

  validates_attachment_presence :image
  validates_attachment_content_type :image, presence: true, content_type: ['image/jpeg', 'image/gif', 'image/png']

  validates :content, presence: true
  validates :title, presence: true

  belongs_to :post_category

  scope :available, -> { where deleted: false }
  scope :search, lambda { |search_string|
    joins("INNER JOIN action_text_rich_texts ON action_text_rich_texts.record_id = posts.id AND record_type = 'Post'")
      .where('posts.title ILIKE ? OR action_text_rich_texts.body ILIKE ?', "%#{search_string}%", "%#{search_string}%")
  }

  def serializable_rich_content
    ActionController::Base.helpers.sanitize(ActionController::Base.helpers.raw(content))
  end

  private

  def send_mail
    list_emails = Subscription.list_email_subscription_posts.pluck(:email).uniq

    list_emails.each do |email|
      SubscriptionMailer.subscription_email_for_post(email, id).deliver_later
    end
  end
end
