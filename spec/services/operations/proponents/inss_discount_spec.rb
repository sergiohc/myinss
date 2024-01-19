require 'rails_helper'

RSpec.describe Operations::Proponents::InssDiscountCalculator, type: :operation do
  subject(:operation) { described_class.new(salary) }

  describe '#execute' do
    context 'when the salary is within the first bracket' do
      let(:salary) { 1400.0 }

      it 'calculates the INSS discount correctly' do
        expect(operation.perform).to eq(105.0) # 1400 * 0.075
      end
    end
  end
end
