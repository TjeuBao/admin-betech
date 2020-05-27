# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @pagy, @users = pagy(User.all, items: params[:size] || 3)
  end
end
