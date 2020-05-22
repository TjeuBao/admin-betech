module Api
  module V1
    class SubscribesController < ApplicationController
      def create
        @subscribe = Subscribe.new(subscribe_params)
        if @subscribe.save
          render json: SubscribeSerializer.new(@subscribe).serialized_json, status: :created
        else
          render json: @subscribe.errors, status: :unprocessable_entity
        end
      end

      # def index
      #   @subscribe = Subscribe.all
      #   render json: SubscribeSerializer.new(@subscribe)
      # end

      def subscribe_params
        params.require(:subscribe).permit(:name, :email, :subscribe_type)
      end
    end
  end
end
