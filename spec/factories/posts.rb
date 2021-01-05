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
FactoryBot.define do
  factory :post do
    title { 'MyString' }
    content { 'MyText' }
  end

  trait :invalid do
    title { '' }
    content { '' }
  end

  trait :with_image_from_file do
    image { Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/fixtures/test.jpg") }
  end
end
