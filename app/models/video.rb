class Video < ApplicationRecord
  include VideoUploader::Attachment.new(:file)
end
