# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProponentsController, type: :controller do # rubocop:disable Metrics/BlockLength
  let(:user) { create(:user) }

  before do
    allow(controller).to receive(:authenticate_user!).and_return(user)
  end

  let(:valid_attributes) do
    FactoryBot.attributes_for(:proponent).merge(
      contacts_attributes: [
        FactoryBot.attributes_for(:personal_contact),
        FactoryBot.attributes_for(:reference_contact)
      ],
      address_attributes: FactoryBot.attributes_for(:address)
    )
  end

  let(:invalid_attributes) do
    valid_attributes.tap do |attributes|
      attributes[:name] = nil
      attributes[:contacts_attributes][0][:name] = ''
      attributes[:address_attributes][:street] = nil
    end
  end

  describe 'GET #index' do
    it 'returns a success response with 5 per page' do
      10.times { create(:proponent) }

      get :index, params: { page: 2 }

      expect(response).to be_successful
      expect(assigns(:proponents).size).to eq(5)
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with Turbo Stream format' do
      it 'creates a new proponent and renders a successful Turbo Stream response' do
        post :create, params: { proponent: valid_attributes }, as: :turbo_stream

        assert_response :success
        assert_equal 'Proponent created', flash.now[:notice]
      end
    end

    context 'with Turbo Stream format' do
      it "returns a success response (i.e. to display the 'new' template)" do
        operation = instance_double(Operations::Proponents::Create)
        allow(Operations::Proponents::Create).to receive(:new).and_return(operation)
        allow(operation).to receive(:perform)
        allow(operation).to receive(:succeeded?).and_return(false)
        allow(operation).to receive_message_chain(:errors, :messages).and_return(["Name can't be blank"])

        post :create, params: { proponent: invalid_attributes }, as: :turbo_stream

        assert_response :success
        assert_equal ["Name can't be blank"], operation.errors.messages
      end
    end

    context 'with Turbo as json' do
      it 'returns a unprocessable_entity response' do
        post :create, params: { proponent: invalid_attributes }, as: :json

        assert_response :unprocessable_entity
      end
    end
  end
end
