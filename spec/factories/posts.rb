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
    # https://stackoverflow.com/questions/40796140/how-to-upload-a-file-in-a-rails-rspec-request-spec
  end
end
