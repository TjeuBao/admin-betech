# frozen_string_literal: true

module Api
  module V1
    class SubscriptionsController < ApplicationController
      skip_before_action :verify_authenticity_token, only: %i[create]

      def create
        @subscription = Subscription.first_or_create(subscription_params)
        if @subscription.persisted?
          render json:
            SubscriptionSerializer.new(@subscription), status: :created
        else
          render json:
            @subscription.errors, status: :unprocessable_entity
        end
      end

      def index
        @pagy, @subscriptions = pagy(extract_subscription, items: per_page)
      end

      private

      def subscription_params
        params.require(:subscription).permit(:email, :subscription_type)
      end

      def extract_subscription
        if params[:search]
          Subscription.search(params[:search])
        else
          Subscription.all.order(id: :desc)
        end
      end
    end
  end
end
