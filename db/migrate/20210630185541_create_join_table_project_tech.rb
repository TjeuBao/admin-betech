class CreateJoinTableProjectTech < ActiveRecord::Migration[6.0]
  def change
    create_join_table :projects, :teches do |t|
      t.index [:project_id, :tech_id]
      t.index [:tech_id, :project_id]
    end
  end
end
