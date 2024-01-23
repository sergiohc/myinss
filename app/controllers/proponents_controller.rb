# frozen_string_literal: true

class ProponentsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_proponent, only: %i[show edit update destroy]
  before_action :set_proponents, only: %i[create index destroy]
  before_action :build_proponent, only: %i[new create]

  def index; end

  def show; end

  def new; end

  def edit; end

  def create
    operation = Operations::Proponents::Create.new(proponent_params)
    operation.perform

    respond_to do |format|
      if operation.succeeded?
        format.turbo_stream { flash.now[:notice] = 'Proponent created' }
        format.json { render json: true }
      else
        msg = operation.errors.messages
        format.turbo_stream { flash.now[:error] = msg }
        format.json { render json: msg, status: :unprocessable_entity }
      end
    end
  end

  def update; end

  def destroy
    @proponent.destroy

    flash[:notice] = 'Proponent removed'

    render turbo_stream: [
      turbo_stream.update('flash', partial: 'shared/flash'),
      turbo_stream.update('proponents', partial: 'proponents/list', locals: { proponents: @proponents })
    ]
  end

  def inss_discount
    operation = Operations::Proponents::InssDiscountCalculator.new(params[:salary].to_f)
    operation.perform

    respond_to do |format|
      if operation.succeeded?
        format.json { render json: { inss_discount: operation.total_discount.floor(2) } }
      else
        format.json { render json: operation.errors.messages, status: :unprocessable_entity }
      end
    end
  end

  private

  def build_proponent
    @proponent = Proponent.new
    @proponent.build_address
    @proponent.contacts.build
  end

  def set_proponents
    @proponents ||= Proponent.page(params[:page]).per(5)
  end

  def set_proponent
    @proponent = Proponent.find(params[:id])
  end

  def proponent_params
    params.require(:proponent).permit(:name, :cpf, :date_of_birth, :salary, :inss_discount,
                                      address_attributes: %i[id street number neighborhood city state cep _destroy],
                                      contacts_attributes: %i[id contact_type phone_number _destroy])
  end
end
