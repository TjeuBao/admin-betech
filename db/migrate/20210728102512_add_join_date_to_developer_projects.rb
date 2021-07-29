class AddJoinDateToDeveloperProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :developer_projects, :join_date, :date
  end
end
