class CreateTodos < ActiveRecord::Migration[7.0]
  def change
    create_table :todos do |t|

      t.string :title
      t.string :description
      t.boolean :complete
      t.datetime :completed_at
      t.datetime :target_date
      t.integer :category
      t.timestamps
    end
  end
end
