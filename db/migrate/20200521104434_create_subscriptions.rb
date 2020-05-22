class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :subscription_type

      t.timestamps
    end
  end
end
