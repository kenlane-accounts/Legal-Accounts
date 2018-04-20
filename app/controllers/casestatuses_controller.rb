class CasestatusesController < ApplicationController
  before_action :set_casestatus, only: [:show, :edit, :update, :destroy]

  # GET /casestatuses
  # GET /casestatuses.json
  def index
    @casestatuses = Casestatus.all
  end

  # GET /casestatuses/1
  # GET /casestatuses/1.json
  def show
  end

  # GET /casestatuses/new
  def new
    @casestatus = Casestatus.new
  end

  # GET /casestatuses/1/edit
  def edit
  end

  # POST /casestatuses
  # POST /casestatuses.json
  def create
    @casestatus = Casestatus.new(casestatus_params)

    respond_to do |format|
      if @casestatus.save
        format.html { redirect_to @casestatus, notice: 'Casestatus was successfully created.' }
        format.json { render :show, status: :created, location: @casestatus }
      else
        format.html { render :new }
        format.json { render json: @casestatus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /casestatuses/1
  # PATCH/PUT /casestatuses/1.json
  def update
    respond_to do |format|
      if @casestatus.update(casestatus_params)
        format.html { redirect_to @casestatus, notice: 'Casestatus was successfully updated.' }
        format.json { render :show, status: :ok, location: @casestatus }
      else
        format.html { render :edit }
        format.json { render json: @casestatus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /casestatuses/1
  # DELETE /casestatuses/1.json
  def destroy
    @casestatus.destroy
    respond_to do |format|
      format.html { redirect_to casestatuses_url, notice: 'Casestatus was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_casestatus
      @casestatus = Casestatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def casestatus_params
      params.require(:casestatus).permit(:code, :description)
    end
end
