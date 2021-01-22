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
class PostSerializer
  include FastJsonapi::ObjectSerializer

  set_type :post

  attributes  :title,
              :source,
              :post_type,
              :created_at,
              :updated_at,
              :slug

  attributes :image, &:image_url

  attributes :content, &:serializable_rich_content
end
