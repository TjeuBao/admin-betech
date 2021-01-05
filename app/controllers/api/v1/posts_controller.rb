# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: %i[show related_posts]
      before_action :prepare_posts, only: :related_posts

      def index
        @pagy, @posts = pagy(extract_post, items: per_page)

        links = {
          preview_page_url: pagenation_url(@pagy.items, @pagy.prev),
          next_page_url: pagenation_url(@pagy.items, @pagy.next)
        }

        render json: PostSerializer.new(@posts, links: links)
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

      def pagenation_url(pagy_items, pagy_page)
        return if pagy_page.blank?

        "#{original_url}?size=#{pagy_items}&page=#{pagy_page}"
      end

      def original_url
        request.original_url[/\A[^?]+/]
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
