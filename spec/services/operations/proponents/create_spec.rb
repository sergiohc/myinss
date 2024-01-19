# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Operations::Proponents::Create, type: :operation do
  subject(:operation) { described_class.new(params) }

  let(:params) do
    FactoryBot.attributes_for(:proponent,
                              name: 'John Doe',
                              cpf: '12345678901',
                              date_of_birth: '1980-01-01',
                              salary: 5000.0,
                              inss_discount: 500.0).merge(
                                contacts_attributes: [
                                  FactoryBot.attributes_for(:personal_contact),
                                  FactoryBot.attributes_for(:reference_contact)
                                ],
                                address_attributes: FactoryBot.attributes_for(:address)
                              )
  end

  describe '#execute' do
    context 'when the parameters are valid' do
      it 'creates a new proponent' do
        expect { operation.perform }.to change(Proponent, :count).by(1)
      end

      it 'calculates the net salary correctly' do
        proponent = operation.perform
        expect(proponent.net_salary).to eq(4500.0)
      end
    end

    context 'when the parameters are invalid' do
      before do
        params[:name] = ''
      end

      it 'does not create a new proponent' do
        expect { operation.perform }.not_to change(Proponent, :count)
      end

      it 'returns the validation errors' do
        operation.perform
        expect(operation.errors.messages[:name][0][0]).to include("can't be blank")
      end
    end
  end
end
