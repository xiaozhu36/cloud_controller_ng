require 'messages/metadata_base_message'
require 'messages/validators'

module VCAP::CloudController
  class BuildpackCreateMessage < MetadataBaseMessage
    register_allowed_keys [:name, :stack, :position, :enabled, :locked]
    validates_with NoAdditionalKeysValidator

    validates :name,
      string: true,
      presence: true,
      allow_nil: false,
      length: { maximum: 250 },
      format: /\A[-\w]+\z/

    validates :stack,
      string: true,
      allow_nil: true,
      length: { maximum: 250 }

    validates :position,
      allow_nil: true,
      numericality: { greater_than_or_equal_to: 1, only_integer: true }

    validates :enabled,
      allow_nil: true,
      boolean: true

    validates :locked,
      allow_nil: true,
      boolean: true
  end
end
