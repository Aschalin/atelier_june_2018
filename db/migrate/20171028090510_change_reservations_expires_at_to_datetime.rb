class ChangeReservationsExpiresAtToDatetime < ActiveRecord::Migration[5.1]
  def change
    remove_column :book_reservations, :expires_at, :date
    add_column :book_reservations, :expires_at, :datetime
  end
end
