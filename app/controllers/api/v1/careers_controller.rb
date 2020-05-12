module Api
  module V1
    class CareersController < ApplicationController
      def index
        @pagy, @careers = pagy(Career.all.order(id: :desc).includes([:rich_text_content]), items: params[:size] || 6)
        render json: @careers
      end

      def show
        render json: @career.as_json.merge(url: @carere.image.url)
      end
    end
  end
end
