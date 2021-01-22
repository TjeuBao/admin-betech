class AddDeletedToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :deleted, :boolean, default: false
  end
end
