class ChangeDefaultValueOfColumnNameForSubscriptions < ActiveRecord::Migration[6.0]
  def change
    change_column :subscriptions, :name, :string, null: true
  end
end
