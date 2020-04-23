class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :titlenull: false
      t.text :contentnull: false

      t.timestamps
    end
  end
end
