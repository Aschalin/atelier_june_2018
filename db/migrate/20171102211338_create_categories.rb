class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
    end

    add_reference :books, :category, index: true
  end
end
