module Api
  module V1
    class PostCategoriesController < ApplicationController
      def filter_post_by_category
        categories = PostCategory.find(params[:id])
        @pagy, @posts = pagy(categories.posts, items: per_page)

        links = {
          preview_page_url: pagenation_url(@pagy.items, @pagy.prev),
          next_page_url: pagenation_url(@pagy.items, @pagy.next)
        }

        render json: PostSerializer.new(@posts, links: links)
      end

      def category_list
        category_list = PostCategory.pluck(:id, :title)

        render json: { data: category_list }
      end

      private

      def pagenation_url(pagy_items, pagy_page)
        return if pagy_page.blank?

        "#{original_url}?size=#{pagy_items}&page=#{pagy_page}"
      end
    end
  end
end
