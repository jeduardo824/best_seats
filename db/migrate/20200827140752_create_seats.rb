class CreateSeats < ActiveRecord::Migration[6.0]
  def change
    create_table :seats do |t|
      t.integer :row
      t.integer :column
      t.string :label
      t.boolean :available
      t.references :venue, null: false, foreign_key: true

      t.timestamps
    end
  end
end
