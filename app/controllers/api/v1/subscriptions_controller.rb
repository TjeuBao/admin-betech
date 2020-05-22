module Api
  module V1
    class SubscriptionsController < ApplicationController
      def create
        @subscription = Subscription.new(subscription_params)
        if @subscription.save
          render json: SubscriptionSerializer.new(@subscription).serialized_json, status: :created
        else
          render json: @subscription.errors, status: :unprocessable_entity
        end
      end

      def subscription_params
        params.require(:subscription).permit(:name, :email, :subscription_type)
      end
    end
  end
end
