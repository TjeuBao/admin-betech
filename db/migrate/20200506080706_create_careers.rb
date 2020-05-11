class CreateCareers < ActiveRecord::Migration[6.0]
  def change
    create_table :careers do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.string :job_type
      t.string :status

      t.timestamps
    end
  end
end
