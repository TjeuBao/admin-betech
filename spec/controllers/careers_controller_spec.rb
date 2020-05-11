require 'rails_helper'

RSpec.describe CareersController, type: :controller do
  let!(:user) { create(:user) }

  context 'before signs user' do
    before { sign_in user }

    describe 'GET index' do
      it 'render the careers#index' do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET show' do
      let(:career) { create(:career) }

      it 'render the careers#show' do
        get :show, params: { id: career.id }
        expect(response).to render_template :show
      end
    end

    describe 'GET new' do
      it 'render the career#new' do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'GET edit' do
      let(:career) { create(:career) }

      it 'render the career#edit' do
        get :edit, params: { id: career.id }
        expect(response).to render_template :edit
      end
    end

    describe 'POST create' do
      context 'with invalid attributes' do
        let(:empty_career_params) { attributes_for(:career, :empty) }

        it 'Career was not created' do
          expect { post :create, params: { career: empty_career_params } }.not_to change(Career, :count)
        end
      end

      context 'Career was successfully created' do
        let(:valid_career_param) { attributes_for(:career) }

        it 'create a new career' do
          expect { post :create, params: { career: valid_career_param } }.to change { Career.count }.by(1)
        end
      end
    end

    describe 'PATCH #update' do
      let(:career) { create(:career) }

      context 'when failed to save career' do
        let(:empty_career_params) { attributes_for(:career, :empty) }
        it 'does not update career' do
          expect { patch :update, params: { id: career.id, career: empty_career_params } }.not_to change(career, :title)
        end
      end
      context 'when save career successfully' do
        let(:new_title) { 'new_title' }
        let(:old_title) { career.title }

        it 'does not create a new career' do
          expect do
            patch :update, params: { id: career.id, career: { title: new_title } }
            career.reload
          end.to change { career.title }.from(old_title).to(new_title)
        end
      end
    end

    describe 'DELETE career' do
      context 'Career was successfully destroyed' do
        let!(:career) { create(:career) }

        it 'delete career' do
          expect { delete :destroy, params: { id: career.id } }.to change { Career.count }.by(-1)
        end
        it 'redirect to index' do
          delete :destroy, params: { id: career.id }
          expect(response).to redirect_to careers_path
        end
      end
    end
  end
end
