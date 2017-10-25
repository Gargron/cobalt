class AccountSerializer < ActiveModel::Serializer
  attributes :id, :username, :display_name
end
