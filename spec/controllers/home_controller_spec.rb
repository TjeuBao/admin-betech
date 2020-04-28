require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET#index' do
    it 'renders the home#index view' do
      get :index
      expect(response).to render_template
    end
  end
end
