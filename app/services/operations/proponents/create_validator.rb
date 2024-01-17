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

        proponent.errors.each do |attribute, error|
          errors.add(attribute, error)
        end
      end

      def validate_address
        return if proponent.address.valid?

        proponent.address.errors.each do |attribute, error|
          errors.add("address.#{attribute}", error)
        end
      end

      def validate_contacts
        proponent.contacts.each do |contact|
          next if contact.valid?

          contact.errors.each do |attribute, error|
            errors.add("contacts.#{attribute}", error)
          end
        end
      end
    end
  end
end