require 'rails_helper'

RSpec.describe Api::V1::SubscriptionsController, type: :controller do
  describe 'POST create' do
    context 'with invalid attributes' do
      let(:empty_subscription_params) { attributes_for(:subscription, :invalid_subscription) }

      it 'Career was not created' do
        expect { post :create, params: { subscription: empty_subscription_params }, format: :json }.not_to change(Subscription, :count)
      end
    end

    context 'Career was successfully created' do
      let(:valid_subscription_param) { attributes_for(:subscription) }

      it 'create a new subscription' do
        expect { post :create, params: { subscription: valid_subscription_param }, format: :json }.to change { Subscription.count }.by(1)
      end
    end
  end
end
