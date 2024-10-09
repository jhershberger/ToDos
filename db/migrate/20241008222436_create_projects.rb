class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.boolean :complete
      t.datetime :completed_at

      t.timestamps
    end

    add_column :todos, :integer, :project_id
  end
end
