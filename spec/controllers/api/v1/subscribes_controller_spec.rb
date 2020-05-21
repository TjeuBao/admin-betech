require 'rails_helper'

RSpec.describe Api::V1::SubscribesController, type: :controller do
  describe 'POST create' do
    context 'with invalid attributes' do
      let(:empty_subscribe_params) { attributes_for(:subscribe, :invalid_subscribe) }

      it 'Career was not created' do
        expect { post :create, params: { subscribe: empty_subscribe_params }, format: :json }.not_to change(Subscribe, :count)
      end
    end

    context 'Career was successfully created' do
      let(:valid_subscribe_param) { attributes_for(:subscribe) }

      it 'create a new subscribe' do
        expect { post :create, params: { subscribe: valid_subscribe_param }, format: :json }.to change { Subscribe.count }.by(1)
      end
    end
  end
end
