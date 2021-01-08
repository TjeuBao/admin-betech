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
FactoryBot.define do
  factory :post_category do
    title  { Faker::Name.name }
  end
end
