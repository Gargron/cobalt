class Activity < ApplicationRecord
  belongs_to :account
  belongs_to :payload
end
