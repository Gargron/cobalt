class Follow < ApplicationRecord
  belongs_to :account
  belongs_to :target_account, class_name: 'Account'
  belongs_to :payload
end
