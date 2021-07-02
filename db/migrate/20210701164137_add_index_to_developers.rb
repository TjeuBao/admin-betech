class AddIndexToDevelopers < ActiveRecord::Migration[6.0]
  def change
    add_index :developers, :full_name, unique: true
    add_index :developers, :company_name, unique: true    
  end
end
