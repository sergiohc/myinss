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
    operation.perform

    respond_to do |format|
      if operation.succeeded?
        format.html { redirect_to root_path, notice: 'Project was successfully created.' }
        format.json { render :index, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: operation.errors.messages, status: :unprocessable_entity }
      end
    end
  end

  def update; end

  def destroy
    @proponent.destroy
    redirect_to proponents_path, notice: 'Proponent was successfully destroyed.'
  end

  def inss_discount
    operation = Operations::Proponents::InssDiscountCalculator.new(params[:salary].to_f)
    operation.perform

    puts operation.total_discount

    respond_to do |format|
      if operation.succeeded?
        format.json { render json: { inss_discount: operation.total_discount.floor(2) } }
      else
        format.json { render json: operation.errors.messages, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_proponent
    @proponent = Proponent.find(params[:id])
  end

  def proponent_params
      params.require(:proponent).permit(:name, :cpf, :date_of_birth, :salary, :inss_discount,
                                    address_attributes: [:id, :street, :number, :neighborhood, :city, :state, :cep, :_destroy],
                                    contacts_attributes: [:id, :contact_type, :phone_number, :_destroy])
  end
end
