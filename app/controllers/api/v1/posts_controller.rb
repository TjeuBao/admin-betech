module Api
  module V1
    class PostsController < ApplicationController
      def index
        @pagy, @posts = pagy(Post.all.order(id: :desc).includes([:rich_text_content]), items: params[:size] || 6)
        render json: PostSerializer.new(@posts).serialized_json
      end

      def show
        render json: PostSerializer.new(@post).serialized_json
        # render json: @post.as_json.merge(url: @post.image.url)
      end
    end
  end
end
