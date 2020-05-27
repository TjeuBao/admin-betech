# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  layout :layout_by_resource

  DEFAULT_PAGE_NUMBER = 6

  private

  def layout_by_resource
    devise_controller? ? 'devise' : 'application'
  end

  def per_page
    params[:size] || DEFAULT_PAGE_NUMBER
  end
end
