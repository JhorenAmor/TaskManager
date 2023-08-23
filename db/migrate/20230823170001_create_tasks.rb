class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :details
      t.decimal :sort_key, default: 0.0000, precision: 8, scale: 4

      t.timestamps
    end
  end
end
