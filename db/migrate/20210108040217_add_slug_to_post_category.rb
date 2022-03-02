class AddSlugToPostCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :post_categories, :slug, :string
    add_index :post_categories, :slug, unique: true

    # PostCategory.find_each(&:save)
  end
end
