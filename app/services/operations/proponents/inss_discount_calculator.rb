module Operations
  module Proponents
    class InssDiscountCalculator  < ComposableOperations::Operation
      processes :params

      # Faixas de salário e suas respectivas alíquotas do INSS 2024
      SALARY_BRACKETS = [
        { min: 0, max: 1412.00, rate: 0.075 },
        { min: 1412.01, max: 2666.68, rate: 0.09 },
        { min: 2666.69, max: 4000.03, rate: 0.12 },
        { min: 4000.04, max: 7786.02, rate: 0.14 }
      ].freeze

      attr_reader :total_discount

      def execute
        build
        calculate
        @total_discount
      end

      private

      def build
        @total_discount = 0
        @salary = params[:salary].to_f
      end

      def calculate
        SALARY_BRACKETS.each do |bracket|
          amount_to_calculate_within_bracket = @salary.clamp(bracket[:min], bracket[:max]) - bracket[:min]
          @total_discount += amount_to_calculate_within_bracket * bracket[:rate]
          break if @salary <= bracket[:max]  # Sai do loop se o salário estiver dentro da faixa atual
        end
      end

    end
  end
end