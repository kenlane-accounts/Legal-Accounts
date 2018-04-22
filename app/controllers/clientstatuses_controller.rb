class ClientstatusesController < ApplicationController
  before_action :set_clientstatus, only: [:show, :edit, :update, :destroy]

  # GET /clientstatuses
  # GET /clientstatuses.json
  def index
    @clientstatuses = Clientstatus.all
  end

  # GET /clientstatuses/1
  # GET /clientstatuses/1.json
  def show
  end

  # GET /clientstatuses/new
  def new
    @clientstatus = Clientstatus.new
  end

  # GET /clientstatuses/1/edit
  def edit
  end

  # POST /clientstatuses
  # POST /clientstatuses.json
  def create
    @clientstatus = Clientstatus.new(clientstatus_params)

    respond_to do |format|
      if @clientstatus.save
        format.html { redirect_to @clientstatus, notice: 'Clientstatus was successfully created.' }
        format.json { render :show, status: :created, location: @clientstatus }
      else
        format.html { render :new }
        format.json { render json: @clientstatus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clientstatuses/1
  # PATCH/PUT /clientstatuses/1.json
  def update
    respond_to do |format|
      if @clientstatus.update(clientstatus_params)
        format.html { redirect_to @clientstatus, notice: 'Clientstatus was successfully updated.' }
        format.json { render :show, status: :ok, location: @clientstatus }
      else
        format.html { render :edit }
        format.json { render json: @clientstatus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clientstatuses/1
  # DELETE /clientstatuses/1.json
  def destroy
    @clientstatus.destroy
    respond_to do |format|
      format.html { redirect_to clientstatuses_url, notice: 'Clientstatus was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clientstatus
      @clientstatus = Clientstatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clientstatus_params
      params.require(:clientstatus).permit(:code, :description)
    end
end
