class AddSlugToCareers < ActiveRecord::Migration[6.0]
  def change
    add_column :careers, :slug, :string
    add_index :careers, :slug, unique: true
  end
end
