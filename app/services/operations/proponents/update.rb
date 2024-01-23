# frozen_string_literal: true

module Operations
  module Proponents
    class Update < ComposableOperations::Operation
      processes :params
      attr_accessor :proponent

      attr_reader :validator

      delegate :errors, to: :validator

      def execute
        binding.pry
        build
        validate
        persist
        @object
      end

      private

      def validate
        @validator = ::Operations::Proponents::CreateValidator.new @proponent

        return if @validator.valid?

        halt @validator.errors
      end

      def build
        net_salary = params[:salary].to_f - params[:inss_discount].to_f

        @proponent.net_salary = net_salary.to_f.round(2)
      end

      def persist
        return @proponent if @proponent.update(params)

        halt @proponent.errors
      end
    end
  end
end
