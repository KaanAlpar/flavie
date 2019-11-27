class AddStartTimestampToSentences < ActiveRecord::Migration[5.2]
  def change
    add_column :sentences, :start_timestamp, :string
  end
end
