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
#  source             :string
#  title              :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Post < ApplicationRecord
  after_commit :send_mail
  has_rich_text :content

  has_attached_file :image, storage: :cloudinary,
                            path: ':id/:style/:filename',
                            styles: { medium: '300x300>', thumb: '100x100>' },
                            default_url: '/images/:style/missing.png'
  validates_attachment_presence :image
  validates_attachment_content_type :image, presence: true, content_type: ['image/jpeg', 'image/gif', 'image/png']
  validates :content, presence: true
  validates :title, presence: true

  private

  def send_mail
    list_email = Subscription.email_subscription_post.pluck(:email)
    SubscriptionMailer.email_subscription(list_email).deliver_later
  end
end
