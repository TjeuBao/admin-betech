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
        t = 3

        @new = Post.where('id > ?', @post.id)
                   .includes([:rich_text_content])
                   .order(id: :desc)
                   .last(t)

        @old = Post.where('id < ?', @post.id)
                   .includes([:rich_text_content])
                   .order(id: :desc)
                   .last(t)

        if @new.blank?
          @old = Post.where('id < ?', @post.id)
                     .includes([:rich_text_content])
                     .order(id: :desc)
                     .first(t)

          render json: PostSerializer.new(@old)
        elsif @old.blank?
          render json: PostSerializer.new(@new)
        elsif @old.length == @new.length
          @old = Post.where('id < ?', @post.id)
                     .includes([:rich_text_content])
                     .order(id: :desc)
                     .first(1)
          @new.shift
          render json: PostSerializer.new(@new + @old)
        elsif (@old.length - @new.length).positive? # > 0
          @old = Post.where('id < ?', @post.id)
                     .includes([:rich_text_content])
                     .order(id: :desc)
                     .first(t)
          render json: PostSerializer.new(@new + @old.shift(t - @new.length))
        else (@old.length - @new.length).negative? # < 0
          @new.shift(t - (t - 1))
          render json: PostSerializer.new(@new + @old.shift(t - @new.length))
        end
      end

      private

      def set_post
        @post = Post.friendly.find(params[:id])
      end
    end
  end
end
