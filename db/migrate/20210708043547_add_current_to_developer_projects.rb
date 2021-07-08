class AddCurrentToDeveloperProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :developer_projects, :current, :boolean
  end
end
