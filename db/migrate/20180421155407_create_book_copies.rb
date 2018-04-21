class CreateBookCopies < ActiveRecord::Migration[5.1]
  def change
    create_table :book_copies do |t|
      t.references :book, foreign_key: true
      t.string :isbn
      t.date :published
      t.integer :format
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
