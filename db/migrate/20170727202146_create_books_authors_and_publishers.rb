class CreateBooksAuthorsAndPublishers < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string  :title
      t.string  :isbn
      t.integer :year

      t.timestamps
    end

    create_table :authors do |t|
      t.string :firstname
      t.string :lastname
    end

    create_table :publishers do |t|
      t.string :name
    end

    add_reference :books, :author, index: true
    add_reference :books, :publisher, index: true
  end
end
