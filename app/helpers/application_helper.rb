# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend
  def alert_class_of_flash(flash_type)
    {
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info'
    }.fetch(flash_type.to_sym, 'alert-info')
  end

  def active_items(item)
    'active' if controller_name == item
  end
end
