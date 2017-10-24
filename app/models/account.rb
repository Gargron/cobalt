class Account < ApplicationRecord
  validates :username, presence: true

  has_many :videos

  def to_param
    username
  end
end
