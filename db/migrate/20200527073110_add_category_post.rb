class AddCategoryPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :post_type, :string
  end
end
