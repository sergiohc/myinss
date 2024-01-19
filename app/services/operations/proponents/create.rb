# frozen_string_literal: true

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
        net_salary = params[:salary].to_f - params[:inss_discount].to_f

        params[:net_salary] = net_salary.round(2)
        @object = Proponent.new(params)
      end

      def persist
        return @object if @object.save

        halt @object.errors
      end
    end
  end
end
