class Video < ApplicationRecord
  include VideoUploader::Attachment.new(:file)

  belongs_to :account, required: true

  scope :published, -> { where(published: true) }
end
