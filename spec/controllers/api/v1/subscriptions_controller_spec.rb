require 'rails_helper'

RSpec.describe Api::V1::SubscriptionsController, type: :controller do
  describe 'POST create' do
    context 'with invalid attributes' do
      let(:empty_subscription_params) { attributes_for(:subscription, :invalid_subscription) }

      it 'Career was not created' do
        expect { post :create, params: { subscription: empty_subscription_params }, format: :json }.not_to change(Subscription, :count)
      end
    end

    context 'susscess created' do
      it 'create a new subscription' do
        type_both = {
          name: 'user',
          email: 'user@gmail.com',
          subscription_type: 'both'
        }

        type_post = {
          name: 'user',
          email: 'user@gmail.com',
          subscription_type: 'post'
        }

        type_career = {
          name: 'user',
          email: 'user@gmail.com',
          subscription_type: 'career'
        }

        expect { post :create, params: { subscription: type_both }, format: :json }
          .to change { Subscription.count }.from(0).to(1)

        expect { post :create, params: { subscription: type_post }, format: :json }
          .to change { Subscription.count }.from(1).to(2)

        expect { post :create, params: { subscription: type_career }, format: :json }
          .to change { Subscription.count }.from(2).to(3)
      end
    end
  end
end
