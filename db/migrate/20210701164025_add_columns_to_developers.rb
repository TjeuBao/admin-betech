class AddColumnsToDevelopers < ActiveRecord::Migration[6.0]
  def change
    add_column :developers, :full_name, :string
    add_column :developers, :company_name, :string
    add_column :developers, :belong_team, :string
  end
end
