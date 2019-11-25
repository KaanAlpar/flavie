class AddLanguageToConversion < ActiveRecord::Migration[5.2]
  def change
    add_column :conversions, :language, :string
  end
end
