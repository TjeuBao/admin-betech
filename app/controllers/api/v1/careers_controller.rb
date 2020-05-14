module Api
  module V1
    class CareersController < ApplicationController
      def index
        @pagy, @careers = pagy(Career.all.order(id: :desc).includes([:rich_text_content]), items: params[:size] || 6)
        render json: CareerSerializer.new(@careers).serialized_json
      end

      def show
        @career = Career.find(params[:id])
        render json: CareerSerializer.new(@career).serialized_json
      end
    end
  end
end
