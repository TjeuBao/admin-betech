# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id                 :bigint           not null, primary key
#  image_content_type :string
#  image_file_name    :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  post_type          :string
#  source             :string
#  title              :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Post < ApplicationRecord
  after_create_commit :send_mail

  has_rich_text :content

  has_attached_file :image, storage: :cloudinary,
                            path: ':id/:style/:filename',
                            styles: { medium: '300x300>', thumb: '100x100>' },
                            default_url: '/images/:style/missing.png'

  validates_attachment_presence :image
  validates_attachment_content_type :image, presence: true, content_type: ['image/jpeg', 'image/gif', 'image/png']
  validates :content, presence: true
  validates :title, presence: true

  scope :search, ->(search_string) { where('lower(title) LIKE ?', "%#{search_string.downcase}%") }

  def serializable_rich_content
    ActionController::Base.helpers.sanitize(ActionController::Base.helpers.raw(content))
  end

  private

  def send_mail
    list_emails = Subscription.list_email_subscription_posts.pluck(:email)
    list_emails.each do |email|
      SubscriptionMailer.subscription_email_for_post(email, id).deliver_later
    end
  end
end
