class RemoveTechTypeFromTech < ActiveRecord::Migration[6.0]
  def change
    remove_column :teches, :tech_type, :string
  end
end
