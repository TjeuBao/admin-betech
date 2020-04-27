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

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new post" do
        expect{
          post :create, contact: Factory.attributes_for(:contact)
        }.to change(Contact,:count).by(1)
      end

      it "redirects to the new contact" do
        post :create, contact: Factory.attributes_for(:contact)
        expect(response).to redirect_to Post.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new contact" do
        expect{
          post :create, contact: Factory.attributes_for(:invalid_contact)
        }.to_not change(Contact,:count)
      end

      it "re-renders the new method" do
        post :create, contact: Factory.attributes_for(:invalid_contact)
        expect(rsponse).to render_template :new
      end
    end
end
