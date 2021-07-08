class AddCurrentProjectToDeveloperProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :developer_projects, :current_project, :bigint
  end
end
