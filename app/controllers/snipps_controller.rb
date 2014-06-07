class SnippsController < ApplicationController
  before_action :set_snipp, only: [:show, :edit, :update, :destroy]

  # GET /snipps
  # GET /snipps.json
  def index
    @snipps = Snipp.all
  end

  # GET /snipps/1
  # GET /snipps/1.json
  def show
  end

  # GET /snipps/new
  def new
    @snipp = Snipp.new
  end

  # GET /snipps/1/edit
  def edit
  end

  # POST /snipps
  # POST /snipps.json
  def create
    @snipp = Snipp.new(snipp_params)

    respond_to do |format|
      if @snipp.save
        format.html { redirect_to @snipp, notice: 'Snipp was successfully created.' }
        format.json { render :show, status: :created, location: @snipp }
      else
        format.html { render :new }
        format.json { render json: @snipp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /snipps/1
  # PATCH/PUT /snipps/1.json
  def update
    respond_to do |format|
      if @snipp.update(snipp_params)
        format.html { redirect_to @snipp, notice: 'Snipp was successfully updated.' }
        format.json { render :show, status: :ok, location: @snipp }
      else
        format.html { render :edit }
        format.json { render json: @snipp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /snipps/1
  # DELETE /snipps/1.json
  def destroy
    @snipp.destroy
    respond_to do |format|
      format.html { redirect_to snipps_url, notice: 'Snipp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_snipp
      @snipp = Snipp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def snipp_params
      params.require(:snipp).permit(:title, :html_code, :css_code, :js_code, :user_id)
    end
end
