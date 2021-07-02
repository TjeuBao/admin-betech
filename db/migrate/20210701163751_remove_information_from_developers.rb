class RemoveInformationFromDevelopers < ActiveRecord::Migration[6.0]
  def change
    remove_column :developers, :information, :string
  end
end
