# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:user) { create(:user) }

  context 'before signs user' do
    before { sign_in user }

    describe 'GET index' do
      it 'render the posts#index' do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET show' do
      let(:post) { create(:post, :with_image_from_file) }

      it 'render the posts#show' do
        get :show, params: { id: post.id }
        expect(response).to render_template :show
      end
    end

    describe 'GET new' do
      it 'render the post#new' do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'GET edit' do
      let(:post) { create(:post, :with_image_from_file) }

      it 'render the post#edit' do
        get :edit, params: { id: post.id }
        expect(response).to render_template :edit
      end
    end

    describe 'POST create' do
      context 'with invalid attributes' do
        let(:invalid_post_param) { attributes_for(:post, :invalid, :with_image_from_file) }

        it 'Post was not created' do
          expect { post :create, params: { post: invalid_post_param } }.not_to change(Post, :count)
        end
      end

      context 'Post was successfully created' do
        let(:valid_post_param) { attributes_for(:post, :with_image_from_file) }

        it 'create a new post' do
          expect { post :create, params: { post: valid_post_param } }.to change { Post.count }.by(1)
        end
      end
    end

    describe 'PATCH #update' do
      let(:post) { create(:post, :with_image_from_file) }

      context 'when failed to save post' do
        let(:invalid_post_params) { attributes_for(:post, :invalid, :with_image_from_file) }
        it 'does not update post' do
          expect { patch :update, params: { id: post.id, post: invalid_post_params } }.not_to change(post, :title)
        end
      end
      context 'when save post successfully' do
        let(:new_title) { 'new_title' }
        let(:old_title) { post.title }

        it 'does not create a new post' do
          expect do
            patch :update, params: { id: post.id, post: { title: new_title } }
            post.reload
          end.to change { post.title }.from(old_title).to(new_title)
        end
      end
    end

    describe 'DELETE post' do
      context 'Post was successfully destroyed' do
        let!(:post) { create(:post, :with_image_from_file) }

        it 'delete post' do
          expect { delete :destroy, params: { id: post.id } }.to change { Post.count }.by(-1)
        end
        it 'redirect to index' do
          delete :destroy, params: { id: post.id }
          expect(response).to redirect_to posts_path
        end
      end
    end
  end
end
