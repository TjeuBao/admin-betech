class RemoveTypeFromTech < ActiveRecord::Migration[6.0]
  def change
    remove_column :teches, :type, :integer
  end
end
