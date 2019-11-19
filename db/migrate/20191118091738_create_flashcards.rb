class CreateFlashcards < ActiveRecord::Migration[5.2]
  def change
    create_table :flashcards do |t|
      t.references :sentence, foreign_key: true
      t.text :phrase
      t.text :phrase_translation

      t.timestamps
    end
  end
end
