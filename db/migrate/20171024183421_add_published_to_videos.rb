class AddPublishedToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :published, :boolean, null: false, default: false
  end
end
