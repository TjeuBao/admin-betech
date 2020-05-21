class CreateSubscribes < ActiveRecord::Migration[6.0]
  def change
    create_table :subscribes do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :subscribe_type, null: false

      t.timestamps
    end
  end
end
