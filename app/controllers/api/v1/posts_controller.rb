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

      def related_posts
        @posts = Post.where('id > ?', params[:id]).order(id: :desc).last(4) + [Post.where('id < ?', params[:id]).order(id: :desc).first]
        render json: PostSerializer.new(@posts)
      end
    end
  end
end
