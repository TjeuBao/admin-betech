class AddTypeToTeches < ActiveRecord::Migration[6.0]
  def change
    add_column :teches, :tech_type, :integer
  end
end
