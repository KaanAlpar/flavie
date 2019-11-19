class CreateSentences < ActiveRecord::Migration[5.2]
  def change
    create_table :sentences do |t|
      t.references :conversion, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
