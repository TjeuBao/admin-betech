# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    user_relations =
      if params[:search]
        User.search(params[:search])
      else
        User.all.order(id: :desc)
      end
    @pagy, @users = pagy(user_relations, items: per_page)
  end
end
