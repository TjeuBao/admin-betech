module Api
  module V1
    class PostCategoriesController < ApplicationController
      before_action :set_post_category, only: %i[filter_post_by_category]

      def filter_post_by_category
        ordered_posts = @post_category.posts.available.order(id: :desc)
        @pagy, @posts = pagy(ordered_posts, items: per_page)

        links = {
          previous_page_url: pagenation_url(@pagy.items, @pagy.prev),
          next_page_url: pagenation_url(@pagy.items, @pagy.next)
        }

        render json: PostSerializer.new(@posts, links: links)
      end

      def category_list
        category_list = PostCategory.pluck(:id, :title)

        render json: { data: category_list }
      end

      private

      def set_post_category
        @post_category = PostCategory.friendly.find(params[:id])
      end

      def pagenation_url(pagy_items, pagy_page)
        return if pagy_page.blank?

        "#{original_url}?size=#{pagy_items}&page=#{pagy_page}"
      end

      def original_url
        request.original_url[/\A[^?]+/]
      end
    end
  end
end
