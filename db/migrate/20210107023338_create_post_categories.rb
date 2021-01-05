class CreatePostCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :post_categories do |t|
      t.string :title, null: false, unique: true

      t.timestamps null: false
    end
  end
end
