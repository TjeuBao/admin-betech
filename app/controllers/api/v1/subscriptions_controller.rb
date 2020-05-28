module Api
  module V1
    class SubscriptionsController < ApplicationController
      skip_before_action :verify_authenticity_token, only: %i[create]

      def create
        @subscription = Subscription.new(subscription_params)
        if @subscription.save
          render json: SubscriptionSerializer.new(@subscription), status: :created
        else
          render json: @subscription.errors, status: :unprocessable_entity
        end
      end

      private

      def subscription_params
        params.require(:subscription).permit(:name, :email, :subscription_type)
      end
    end
  end
end
