class AddBookReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :book_reservations do |t|
      t.string :status # AVAILABLE, PENDING, TAKEN
      t.date :expires_at
      t.timestamps
    end

    add_reference :book_reservations, :book, index: true
    add_reference :book_reservations, :user, index: true
  end
end
