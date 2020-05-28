module Api
  module V1
    class CareersController < ApplicationController
      def index
        @careers = Career.all
        render json: CareerSerializer.new(@careers)
      end

      def show
        @career = Career.find(params[:id])
        render json: CareerSerializer.new(@career)
      end
    end
  end
end
