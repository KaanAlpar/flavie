class AddFlashcardFieldsToFlashcards < ActiveRecord::Migration[5.2]
  def change
    add_column :flashcards, :easiness_factor, :float,   default: 2.5
    add_column :flashcards, :repetitions, :integer, default: 0
    add_column :flashcards, :interval, :integer, default: 0
    add_column :flashcards, :due, :date, default: nil
    add_column :flashcards, :studied_at, :date, default: nil
  end
end
