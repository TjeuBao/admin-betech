class RemoveDevelopmentTypeFromProject < ActiveRecord::Migration[6.0]
  def change
    remove_column :projects, :development_type, :integer
  end
end
