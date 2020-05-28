module Api
  module V1
    class PostsController < ApplicationController
      def index
        @posts = Post.all
        render json: PostSerializer.new(@posts)
      end

      def show
        @post = Post.find(params[:id])
        render json: PostSerializer.new(@post)
      end
    end
  end
end
