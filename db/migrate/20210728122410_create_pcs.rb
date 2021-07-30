class CreatePcs < ActiveRecord::Migration[6.0]
  def change
    create_table :pcs do |t|
      t.string :full_name, null: false
      t.string :company_name, null: false
      t.string :level, null: false

      t.timestamps
    end
  end
end
