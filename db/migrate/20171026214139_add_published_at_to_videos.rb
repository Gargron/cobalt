class AddPublishedAtToVideos < ActiveRecord::Migration[5.1]
  def change
    remove_column :videos, :published, :boolean, null: false, default: false
    add_column :videos, :published_at, :datetime, null: true, default: nil
  end
end
