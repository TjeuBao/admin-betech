# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @pagy, @users = pagy(extract_user, items: per_page)
  end

  private

  def extract_user
    if params[:search]
      User.search(params[:search])
    else
      User.all.order(id: :desc)
    end
  end
end
