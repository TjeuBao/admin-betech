class ChangeDataTypeForTechType < ActiveRecord::Migration[6.0]
  def change
    change_column :teches, :tech_type, :string
  end
end
