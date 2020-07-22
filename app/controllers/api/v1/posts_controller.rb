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
        num_limited = 3

        posts = Post.order(id: :desc)
        latest_posts = posts.where('id > ?', @post.id).last(num_limited)
        oldest_posts = posts.where('id < ?', @post.id).first(num_limited)

        posts_closest = if latest_posts.empty? || oldest_posts.empty?
                          oldest_posts.presence || latest_posts
                        else
                          calc_related_posts(latest_posts, oldest_posts, num_limited)
                        end

        render json: PostSerializer.new(posts_closest)
      end

      private

      def calc_related_posts(latest_posts, oldest_posts, num_limited)
        latest_posts_length = latest_posts.length

        if latest_posts_length == num_limited
          latest_posts[1..-1] + oldest_posts[0..0]
        else
          position = (num_limited - latest_posts_length - 1)
          latest_posts + oldest_posts[0..position]
        end
      end

      def set_post
        @post = Post.friendly.find(params[:id])
      end
    end
  end
end
