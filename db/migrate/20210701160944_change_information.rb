class ChangeInformation < ActiveRecord::Migration[6.0]
  def change
    rename_column :developers, :infomation, :information
  end
end
