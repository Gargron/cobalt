class Payload < ApplicationRecord
  self.primary_key = :id

  scope :local,  -> { where(local: true) }
  scope :remote, -> { where(local: false) }
end
