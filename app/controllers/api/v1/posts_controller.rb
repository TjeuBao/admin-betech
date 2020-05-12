module Api
  module V1
    class PostsController < ApplicationController
      def index
        @pagy, @posts = pagy(Post.all.order(id: :desc).includes([:rich_text_content]), items: params[:size] || 6)
        render json: @posts
      end

      def show
        render json: @post.as_json.merge(url: @post.image.url)
      end
    end
  end
end
