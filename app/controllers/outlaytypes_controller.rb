class OutlaytypesController < ApplicationController
  before_action :set_outlaytype, only: [:show, :edit, :update, :destroy]

  # GET /outlaytypes
  # GET /outlaytypes.json
  def index
    @outlaytypes = Outlaytype.all
  end

  # GET /outlaytypes/1
  # GET /outlaytypes/1.json
  def show
  end

  # GET /outlaytypes/new
  def new
    @outlaytype = Outlaytype.new
  end

  # GET /outlaytypes/1/edit
  def edit
  end

  # POST /outlaytypes
  # POST /outlaytypes.json
  def create
    @outlaytype = Outlaytype.new(outlaytype_params)

    respond_to do |format|
      if @outlaytype.save
        format.html { redirect_to @outlaytype, notice: 'Outlaytype was successfully created.' }
        format.json { render :show, status: :created, location: @outlaytype }
      else
        format.html { render :new }
        format.json { render json: @outlaytype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /outlaytypes/1
  # PATCH/PUT /outlaytypes/1.json
  def update
    respond_to do |format|
      if @outlaytype.update(outlaytype_params)
        format.html { redirect_to @outlaytype, notice: 'Outlaytype was successfully updated.' }
        format.json { render :show, status: :ok, location: @outlaytype }
      else
        format.html { render :edit }
        format.json { render json: @outlaytype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /outlaytypes/1
  # DELETE /outlaytypes/1.json
  def destroy
    @outlaytype.destroy
    respond_to do |format|
      format.html { redirect_to outlaytypes_url, notice: 'Outlaytype was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_outlaytype
      @outlaytype = Outlaytype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def outlaytype_params
      params.require(:outlaytype).permit(:outcode, :outdesc)
    end
end
