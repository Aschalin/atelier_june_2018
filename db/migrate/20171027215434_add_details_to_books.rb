class AddDetailsToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :page_count, :integer
    add_column :books, :published_date, :string
    add_column :books, :language, :string
    add_column :books, :preview_link, :string
    add_column :books, :info_link, :string
  end
end
