# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  layout :layout_by_resource

  private

  def layout_by_resource
    devise_controller? ? 'devise' : 'application'
  end


end
