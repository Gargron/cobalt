class Video < ApplicationRecord
  include VideoUploader::Attachment.new(:file)

  belongs_to :account

  scope :published, -> { where.not(published_at: nil) }

  def published
    !published_at.nil?
  end

  def published?
    published
  end

  def published=(val)
    if val
      self.published_at = Time.now.utc
    else
      self.published_at = nil
    end
  end

  after_commit on: :destroy do
    ActivityManager.create(:delete, self) if published?
  end
end
