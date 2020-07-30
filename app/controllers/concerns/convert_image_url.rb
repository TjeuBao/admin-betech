module ConvertImageUrl
  extend ActiveSupport::Concern

  def image_url(*args)
    url = image.url(*args)
    return url unless image.options[:storage] == :cloudinary

    url&.gsub(%r{/v\d+\//}, '')
  end
end
