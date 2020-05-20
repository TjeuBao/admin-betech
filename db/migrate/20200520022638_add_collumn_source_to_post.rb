class AddCollumnSourceToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :source, :string
  end
end
