module Api
  module V1
    class PostsController < ApplicationController
      def index
        @pagy, @posts = pagy(Post.all.order(id: :desc).includes([:rich_text_content]), items: params[:size] || 6)
        render json: PostSerializer.new(@posts).serialized_json
      end

      def show
        @post = Post.find(params[:id])
        render json: PostSerializer.new(@post).serialized_json
      end
    end
  end
end
