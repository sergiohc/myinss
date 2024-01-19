# frozen_string_literal: true

module Operations
  module Proponents
    class CreateValidator
      include ActiveModel::Model

      attr_reader :proponent

      validate :validate_proponent
      validate :validate_address
      validate :validate_contacts

      def initialize(proponent)
        @proponent = proponent
      end

      private

      def validate_proponent
        return if proponent.valid?

        proponent.errors.messages.each do |attribute, message|
          errors.add(attribute, message)
        end
      end

      def validate_address
        return if proponent&.address&.valid?

        proponent.errors.add_nested('address', 'street', 'is required')
      end

      def validate_contacts
        proponent.contacts.each do |contact|
          next if contact.valid?

          contact.errors.add_nested('name', 'is required')
        end
      end
    end
  end
end
