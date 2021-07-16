class ChangeCurrentProject < ActiveRecord::Migration[6.0]
  def change
    rename_column :developer_projects, :current_project, :current
  end
end
