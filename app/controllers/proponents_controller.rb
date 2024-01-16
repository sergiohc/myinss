class ProponentsController < ApplicationController
  before_action :set_proponent, only: %i[ show edit update destroy ]

  # GET /proponents or /proponents.json
  def index
    @proponents = Proponent.all
  end

  # GET /proponents/1 or /proponents/1.json
  def show; end

  # GET /proponents/new
  def new
    @proponent = Proponent.new
  end

  # GET /proponents/1/edit
  def edit; end

  # POST /proponents or /proponents.json
  def create
    @proponent = Proponent.new(proponent_params)

    respond_to do |format|
      if @proponent.save
        format.turbo_stream
        format.html { redirect_to @proponent, notice: "Proponent was successfully created." }
        format.json { render :show, status: :created, location: @proponent }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@proponent, partial: "proponents/form", locals: { proponent: @proponent }) }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @proponent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proponents/1 or /proponents/1.json
  def update
    respond_to do |format|
      if @proponent.update(proponente_params)
        format.turbo_stream
        format.html { redirect_to @proponent, notice: "Proponente was successfully updated." }
        format.json { render :show, status: :ok, location: @proponent }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@proponent, partial: "proponents/form", locals: { proponent: @proponent }) }
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @proponent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proponents/1 or /proponents/1.json
  def destroy
    @proponent.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to proponents_url, notice: "Proponent was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proponent
      @proponent = Proponent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def proponent_params
      params.require(:proponent).permit(:name, :cpf, :date_of_birth, :salary,
                                        address_attributes: [:street, :number, :neighborhood, :city, :cep, :state],
                                        contacts_attributes: [:id, :contact_type, :phone_number, :_destroy])
    end
end
