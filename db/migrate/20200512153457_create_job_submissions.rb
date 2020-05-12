class CreateJobSubmissions < ActiveRecord::Migration[6.0]
  def change
    create_table :job_submissions do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :port_folio
      t.text :answer
      t.integer :career_id

      t.timestamps
    end
  end
end
