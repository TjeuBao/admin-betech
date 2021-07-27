class AddNewColumnToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :start_date, :date
    add_column :projects, :deployment, :string
    add_column :projects, :development_type, :integer
  end
end
