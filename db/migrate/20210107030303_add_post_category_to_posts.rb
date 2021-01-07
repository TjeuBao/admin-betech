class AddPostCategoryToPosts < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :post_category, index: true
  end
end
