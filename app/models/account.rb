class Account < ApplicationRecord
  validates :username, presence: true

  has_many :videos
  has_many :activities

  def to_param
    username
  end
end
