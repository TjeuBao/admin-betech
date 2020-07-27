# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: %i[show related_posts]
      before_action :prepare_posts, only: :related_posts

      def index
        @pagy, @posts = pagy(extract_post, items: per_page)

        result = {
          link: {
            preview_page_url: check_preview_url(@pagy.items, @pagy.prev),
            next_page_url: check_next_url(@pagy.items, @pagy.next)
          },
          posts: PostSerializer.new(@posts)
        }

        render json: result
      end

      def show
        render json: PostSerializer.new(@post)
      end

      def related_posts
        posts_closest = if @latest_posts.empty? || @oldest_posts.empty?
                          @oldest_posts.presence || @latest_posts
                        else
                          rank_posts(@latest_posts, @oldest_posts, @quality)
                        end

        render json: PostSerializer.new(posts_closest)
      end

      private

      def check_preview_url(pagy_items, pagy_prev)
        return if pagy_prev.blank?

        "#{ENV['ADMIN_PANEL_POST_URL']}?size=#{pagy_items}&page=#{pagy_prev}"
      end

      def check_next_url(pagy_items, pagy_next)
        return if pagy_next.blank?

        "#{ENV['ADMIN_PANEL_POST_URL']}?size=#{pagy_items}&page=#{pagy_next}"
      end

      def set_post
        @post = Post.friendly.find(params[:id])
      end

      def rank_posts(latest_posts, oldest_posts, num_limited)
        latest_posts_length = latest_posts.length
        oldest_posts_length = oldest_posts.length

        if latest_posts_length == num_limited
          latest_posts[1..-1] + oldest_posts[0..0]
        elsif (latest_posts_length + oldest_posts_length) <= num_limited
          latest_posts + oldest_posts
        else
          position = (num_limited - latest_posts_length - 1)
          latest_posts + oldest_posts[0..position]
        end
      end

      def prepare_posts
        @quality = params[:num_limited].presence || 3

        posts = Post.order(id: :desc)
        @latest_posts = posts.where('id > ?', @post.id).last(@quality)
        @oldest_posts = posts.where('id < ?', @post.id).first(@quality)
      end

      def extract_post
        if params[:search]
          Post.search(params[:search])
        else
          Post.all.order(id: :desc)
        end
      end
    end
  end
end
