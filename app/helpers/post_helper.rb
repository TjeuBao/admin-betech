module PostHelper
  extend ActiveSupport::Concern

  class_methods do
    def image_url(post)
      post.image.url
    end
  end
end
