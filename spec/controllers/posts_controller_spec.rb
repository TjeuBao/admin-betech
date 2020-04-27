require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'GET#index' do
    it 'renders the posts#index' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET#show' do
    let(:post) { create(:post) }

    it 'renders the posts#show' do
      get :show, params: { id: post.id }
      expect(response).to render_template :show
    end
  end

  describe 'GET#new' do
    it 'renders the post#new' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET#edit' do
    let(:post) { create(:post) }

    it 'renders the post#edit' do
      get :edit, params: { id: post.id }
      expect(response).to render_template :edit
    end
  end
end
