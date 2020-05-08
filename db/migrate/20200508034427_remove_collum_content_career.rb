class RemoveCollumContentCareer < ActiveRecord::Migration[6.0]
  def change
    remove_column :careers, :content
  end
end
