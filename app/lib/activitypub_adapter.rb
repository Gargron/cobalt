# frozen_string_literal: true

class ActivityPubAdapter < ActiveModelSerializers::Adapter::Base
  CONTEXT = {
    '@context': [
      'https://www.w3.org/ns/activitystreams',

      {
        'manuallyApprovesFollowers' => 'as:manuallyApprovesFollowers',
      },
    ],
  }.freeze

  def self.default_key_transform
    :camel_lower
  end

  def serializable_hash(options = nil)
    options = serialization_options(options)
    serialized_hash = ActiveModelSerializers::Adapter::Attributes.new(serializer, instance_options).serializable_hash(options)
    CONTEXT.merge(self.class.transform_key_casing!(serialized_hash, instance_options))
  end
end
