require "shrine"
require "shrine/storage/file_system"

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
  store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/store"),
}

Shrine.plugin :backgrounding

Shrine::Attacher.promote { |data| PromoteWorker.perform_async(data) }
Shrine::Attacher.delete  { |data| DeleteWorker.perform_async(data) }
