class RenameUrlToVideoIdForConversion < ActiveRecord::Migration[5.2]
  def change
    rename_column :conversions, :url, :video_id
  end
end
