class CreatePcProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :pc_projects do |t|
      t.date :join_date
      t.references :pc, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
