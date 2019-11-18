class AddDeckIdToFlashcards < ActiveRecord::Migration[5.2]
  def change
    add_reference :flashcards, :deck, foreign_key: true
  end
end
