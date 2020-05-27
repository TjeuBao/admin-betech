# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:search]
      @pagy, @users = pagy(search, items: per_page)
    else
      @pagy, @users = pagy(User.all.order(id: :desc), items: per_page)
    end
  end

  def search
    User.where('lower(email) LIKE ?', '%' + params[:search].downcase + '%')
  end
end
