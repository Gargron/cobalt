class Account < ApplicationRecord
  validates :username, presence: true

  has_many :videos
  has_many :activities

  has_many :active_relationships,  class_name: 'Follow', foreign_key: 'account_id',        dependent: :destroy
  has_many :passive_relationships, class_name: 'Follow', foreign_key: 'target_account_id', dependent: :destroy

  has_many :following, -> { order('follows.id desc') }, through: :active_relationships,  source: :target_account
  has_many :followers, -> { order('follows.id desc') }, through: :passive_relationships, source: :account

  scope :local,  -> { where(local: true) }
  scope :remote, -> { where(local: false) }

  def to_param
    username
  end

  def key
    @key ||= OpenSSL::PKey::RSA.new(attributes['key'])
  end

  before_create do
    self.key = OpenSSL::PKey::RSA.new(Rails.env.test? ? 512 : 2048).to_pem if local?
  end
end
