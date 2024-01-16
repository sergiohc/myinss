class ProponentsController < ApplicationController
  before_action :set_proponent, only: %i[ show edit update destroy ]

  # GET /proponents or /proponents.json
  def index
    @proponents = Proponent.all.group_by { |proponent| salary_range(proponent.salary) }
    @proponents = @proponents.sort_by { |range, _| range[:id] }.to_h
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

  def salary_range(salary)
    case salary
    when 0..1045
      { id: 1, range: 'Até R$ 1.045,00' }
    when 1045.01..2089.60
      { id: 2, range: 'De R$ 1.045,01 a R$ 2.089,60' }
    when 2089.61..3134.40
      { id: 3, range: 'De R$ 2.089,61 até R$ 3.134,40' }
    when 3134.41..6101.06
      { id: 4, range: 'De R$ 3.134,41 até R$ 6.101,06' }
    else
      { id: 5, range: 'Acima de R$ 6.101,06' }
    end
  end
end
