# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    user_relations =
      if params[:search]
        User.where('lower(email) LIKE ?', '%' + params[:search].downcase + '%')
      else
        User.all.order(id: :desc)
      end
    @pagy, @users = pagy(user_relations, items: params[:size] || 6)
  end
end
