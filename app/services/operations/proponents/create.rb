module Operations
  module Proponents
    class Create < ComposableOperations::Operation
      processes :params

      attr_reader :object, :validator

      delegate :errors, to: :validator

      def execute
        build
        validate
        persist
        @object
      end

      private

      def validate
        @validator = ::Operations::Proponents::CreateValidator.new @object

        return if @validator.valid?

        halt @validator.errors
      end

      def build
        @object = Proponent.new(params)
        @object.build_address(params[:address_attributes])
        params[:contacts_attributes].each do |contact_params|
          @object.contacts.build(contact_params)
        end
      end

      def persist
        return @object if @object.save

        halt @object.errors
      end
    end
  end
end
