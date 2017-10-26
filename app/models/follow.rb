class Follow < ApplicationRecord
  belongs_to :account
  belongs_to :target_account
end
