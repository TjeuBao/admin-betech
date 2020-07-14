# == Schema Information
#
# Table name: careers
#
#  id                 :bigint           not null, primary key
#  image_content_type :string
#  image_file_name    :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  job_type           :string
#  status             :string
#  title              :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Career < ApplicationRecord
  after_create_commit :send_mail

  has_many :job_submisstion

  STATUSES = %i[open job_filled].map(&:to_s).map(&:titleize)
  JOB = %i[full_time part_time].map(&:to_s).map(&:titleize)

  has_rich_text :content
  has_attached_file :image, storage: :cloudinary,
                            path: ':id/:style/:filename',
                            styles: { medium: '300x300>', thumb: '100x100>' },
                            default_url: '/images/:style/missing.png'

  validates_attachment_content_type :image,
                                    content_type: ['image/jpeg', 'image/gif', 'image/png']

  validates :content, presence: true
  validates :title, presence: true
  validates_inclusion_of :job_type, in: JOB
  validates_inclusion_of :status, in: STATUSES

  scope :search, ->(search_string) { where('lower(title) LIKE ?', "%#{search_string.downcase}%") }

  def serializable_rich_content
    ActionController::Base.helpers.sanitize(ActionController::Base.helpers.raw(content))
  end

  private

  def send_mail
    return unless Career.last.status == 'Open'

    list_emails = Subscription.list_email_subscription_careers.pluck(:email)
    list_emails.each do |email|
      SubscriptionMailer.subscription_email_for_career(email, id).deliver_later
    end
  end
end
