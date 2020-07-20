module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, except: :index

      def index
        @posts = Post.all
        render json: PostSerializer.new(@posts)
      end

      def show
        render json: PostSerializer.new(@post)
      end

      def related_posts
        @results = (Post.where('id > ?', @post.id).includes([:rich_text_content]).order(id: :desc).last(4) + [Post.where('id < ?', @post.id).includes([:rich_text_content]).order(id: :desc).first])
        render json: PostSerializer.new(@results.compact)
      end

      private

      def set_post
        @post = Post.friendly.find(params[:id])
      end
    end
  end
end
