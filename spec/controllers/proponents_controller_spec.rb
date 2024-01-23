# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProponentsController, type: :controller do # rubocop:disable Metrics/BlockLength
  include ProponentsOperationHelpers

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
        operation = stub_failed_create_operation

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

  describe 'PATCH #update' do
    let(:proponent) { create(:proponent) }

    before do
      get :edit, params: { id: proponent.id }
    end

    context 'with Turbo Stream format and valid attributes' do
      it 'updates the proponent and renders a successful Turbo Stream response' do
        stub_valid_update_operation(proponent)
        patch :update, params: { id: proponent.id, proponent: valid_attributes }, as: :turbo_stream

        assert_response :success
        assert_equal 'Proponent updated', flash.now[:notice]
      end
    end

    context 'with Turbo Stream format and invalid attributes' do
      it "returns a success response (i.e., to display the 'edit' template) and renders errors" do
        operation = stub_failed_update_operation(proponent)

        patch :update, params: { id: proponent.id, proponent: invalid_attributes }, as: :turbo_stream

        assert_response :success
        assert_equal ["Name can't be blank"], operation.errors.messages
      end
    end

    context 'with Turbo as JSON' do
      it 'returns an unprocessable_entity response with errors' do
        operation = stub_failed_update_operation(proponent)

        patch :update, params: { id: proponent.id, proponent: invalid_attributes }, as: :json

        assert_response :unprocessable_entity
        assert_equal ["Name can't be blank"], operation.errors.messages
      end
    end
  end
end
