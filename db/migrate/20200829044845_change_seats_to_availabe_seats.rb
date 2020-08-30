class ChangeSeatsToAvailabeSeats < ActiveRecord::Migration[6.0]
  def change
    remove_column :seats, :available
    rename_table :seats, :available_seats
  end
end
