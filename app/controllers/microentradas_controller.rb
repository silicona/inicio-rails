class MicroentradasController < ApplicationController
  before_action :set_microentrada, only: [:show, :edit, :update, :destroy]

  # GET /microentradas
  # GET /microentradas.json
  def index
    @microentradas = Microentrada.all
  end

  # GET /microentradas/1
  # GET /microentradas/1.json
  def show
  end

  # GET /microentradas/new
  def new
    @microentrada = Microentrada.new
  end

  # GET /microentradas/1/edit
  def edit
  end

  # POST /microentradas
  # POST /microentradas.json
  def create
    @microentrada = Microentrada.new(microentrada_params)

    respond_to do |format|
      if @microentrada.save
        format.html { redirect_to @microentrada, notice: 'Microentrada creada con éxito.' }
        format.json { render :show, status: :created, location: @microentrada }
      else
        format.html { render :new }
        format.json { render json: @microentrada.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /microentradas/1
  # PATCH/PUT /microentradas/1.json
  def update
    respond_to do |format|
      if @microentrada.update(microentrada_params)
        format.html { redirect_to @microentrada, notice: 'Microentrada actualizada con éxito.' }
        format.json { render :show, status: :ok, location: @microentrada }
      else
        format.html { render :edit }
        format.json { render json: @microentrada.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /microentradas/1
  # DELETE /microentradas/1.json
  def destroy
    @microentrada.destroy
    respond_to do |format|
      format.html { redirect_to microentradas_url, notice: 'Microentrada borrada con éxito.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_microentrada
      @microentrada = Microentrada.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def microentrada_params
      params.require(:microentrada).permit(:contenido, :usuario_id)
    end
end
