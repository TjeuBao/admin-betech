class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :content

  attribute :content do |object|
    "#{object.content}.to_s"
  end
end
