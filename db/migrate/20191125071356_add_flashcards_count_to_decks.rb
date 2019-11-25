class AddFlashcardsCountToDecks < ActiveRecord::Migration[5.2]
  def up
    add_column :decks, :flashcards_count, :integer, default: 0
    Deck.all.each { |deck| Deck.reset_counters(deck.id, :flashcards) }
  end

  def down
    remove_column :decks, :flashcards_count
  end
end
