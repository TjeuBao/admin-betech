class CreateDevelopmentTypesProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :development_types_projects do |t|
      t.references :development_type, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
