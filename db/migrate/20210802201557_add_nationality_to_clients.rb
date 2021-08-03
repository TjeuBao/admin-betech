class AddNationalityToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :nationality, :string
  end
end
