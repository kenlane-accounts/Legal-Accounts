class NomtransController < ApplicationController
  before_action :set_nomtran, only: [:show, :edit, :update, :destroy]

  # GET /nomtrans
  # GET /nomtrans.json
  def index
    @nomtrans = Nomtran.all
  end

  # GET /nomtrans/1
  # GET /nomtrans/1.json
  def show
  end

  # GET /nomtrans/new
  def new
    @nomtran = Nomtran.new
  end

  # GET /nomtrans/1/edit
  def edit
  end

  # POST /nomtrans
  # POST /nomtrans.json
  def create
    @nomtran = Nomtran.new(nomtran_params)

    respond_to do |format|
      if @nomtran.save
        format.html { redirect_to @nomtran, notice: 'Nomtran was successfully created.' }
        format.json { render :show, status: :created, location: @nomtran }
      else
        format.html { render :new }
        format.json { render json: @nomtran.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nomtrans/1
  # PATCH/PUT /nomtrans/1.json
  def update
    respond_to do |format|
      if @nomtran.update(nomtran_params)
        format.html { redirect_to @nomtran, notice: 'Nomtran was successfully updated.' }
        format.json { render :show, status: :ok, location: @nomtran }
      else
        format.html { render :edit }
        format.json { render json: @nomtran.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nomtrans/1
  # DELETE /nomtrans/1.json
  def destroy
    @nomtran.destroy
    respond_to do |format|
      format.html { redirect_to nomtrans_url, notice: 'Nomtran was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nomtran
      @nomtran = Nomtran.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nomtran_params
      params.require(:nomtran).permit(:tran_id, :ttype, :nominal_id, :date, :amount, :vat_id, :supplier_id, :nomcode)
    end
end
