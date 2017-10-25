class Video < ApplicationRecord
  include VideoUploader::Attachment.new(:file)

  belongs_to :account, required: true

  scope :published, -> { where(published: true) }

  after_commit on: :destroy do
    ActivityManager.create(:delete, self) if published?
  end
end
