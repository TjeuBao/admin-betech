class RemoveCurrentFromDeveloperProject < ActiveRecord::Migration[6.0]
  def change
    remove_column :developer_projects, :current, :bigint
  end
end
