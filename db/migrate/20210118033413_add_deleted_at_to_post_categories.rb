class AddDeletedAtToPostCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :post_categories, :deleted_at, :timestamp
  end
end
