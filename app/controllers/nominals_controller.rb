class NominalsController < ApplicationController
  before_action :set_nominal, only: [:show, :edit, :update, :destroy]

  # GET /nominals
  # GET /nominals.json
  def index
    @nominals = Nominal.all
  end

  # GET /nominals/1
  # GET /nominals/1.json
  def show
  end

  # GET /nominals/new
  def new
    @nominal = Nominal.new
  end

  # GET /nominals/1/edit
  def edit
  end

  # POST /nominals
  # POST /nominals.json
  def create
    @nominal = Nominal.new(nominal_params)

    respond_to do |format|
      if @nominal.save
        format.html { redirect_to @nominal, notice: 'Nominal was successfully created.' }
        format.json { render :show, status: :created, location: @nominal }
      else
        format.html { render :new }
        format.json { render json: @nominal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nominals/1
  # PATCH/PUT /nominals/1.json
  def update
    respond_to do |format|
      if @nominal.update(nominal_params)
        format.html { redirect_to @nominal, notice: 'Nominal was successfully updated.' }
        format.json { render :show, status: :ok, location: @nominal }
      else
        format.html { render :edit }
        format.json { render json: @nominal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nominals/1
  # DELETE /nominals/1.json
  def destroy
    @nominal.destroy
    respond_to do |format|
      format.html { redirect_to nominals_url, notice: 'Nominal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nominal
      @nominal = Nominal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nominal_params
      params.require(:nominal).permit(:code, :desc, :isoffice, :isclient, :isdeposit)
    end
end
