class ProponentsController < ApplicationController
  before_action :set_proponent, only: [:show, :edit, :update, :destroy]

  def index
    @proponents = Proponent.page(params[:page]).per(5)
  end

  def show; end

  def new
    @proponent = Proponent.new
    @proponent.build_address
    @proponent.contacts.build
  end

  def edit; end

  def create
    operation = Operations::Proponents::Create.new(proponent_params)

    if operation.perform
      redirect_to operation.object, notice: 'Proponent was successfully created.'
    else
      @proponent = operation.object
      render :new
    end
  end

  def update
    if @proponent.update(proponent_params)
      redirect_to @proponent, notice: 'Proponent was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @proponent.destroy
    redirect_to proponents_url, notice: 'Proponent was successfully destroyed.'
  end

  private

  def set_proponent
    @proponent = Proponent.find(params[:id])
  end

  def proponent_params
    params.require(:proponent).permit(:cpf, address_attributes: [:id, :street, :city, :state, :country, :zip], contacts_attributes: [:id, :name, :phone, :_destroy])
  end
end