class Activity < ApplicationRecord
  belongs_to :account, required: true
  belongs_to :payload, required: true
end
