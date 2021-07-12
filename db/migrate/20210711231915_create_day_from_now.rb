class CreateDayFromNow < ActiveRecord::Migration[6.0]
  def change
    create_table :day_from_nows do |t|
      t.integer :day
    end
  end
end
