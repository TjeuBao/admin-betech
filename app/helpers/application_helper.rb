module ApplicationHelper
  def alert_class_of_flash(flash_type)
    { success: 'alert-success', error: 'alert-danger', alert: 'alert-warning', notice: 'alert-info' }.fetch(flash_type.to_sym, flash_type.to_s)
  end
end
