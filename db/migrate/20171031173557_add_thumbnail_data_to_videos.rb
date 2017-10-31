class AddThumbnailDataToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :thumbnail_data, :text
  end
end
