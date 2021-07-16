class CreateDeveloperTeches < ActiveRecord::Migration[6.0]
  def change
    create_table :developer_teches do |t|
      t.references :developer, null: false, foreign_key: true
      t.references :tech, null: false, foreign_key: true

      t.timestamps
    end
  end
end
