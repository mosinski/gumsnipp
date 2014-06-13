class SnippsController < ApplicationController
  before_action :set_snipp, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :only => [:new, :edit, :update, :destroy]

  def index
    @snipps = Snipp.all
  end

  def show
    @snipp = Snipp.find(params[:id])
    @snipp.html_code = CodeRay.scan(@snipp.html_code, :html).div(:line_numbers => :table) if @snipp.html_code.present?
    @snipp.css_code = CodeRay.scan(@snipp.css_code, :css).div(:line_numbers => :table) if @snipp.css_code.present?
    @snipp.js_code = CodeRay.scan(@snipp.js_code, :css).div(:line_numbers => :table) if @snipp.js_code.present?
    Visit.track(@snipp, request.remote_ip)
  end

  def new
    @snipp = Snipp.new
  end

  def edit
  end

  def create
    @snipp = Snipp.new(snipp_params)
    @snipp.user_id = current_user.id

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

  def destroy
    @snipp.destroy
    respond_to do |format|
      format.html { redirect_to snipps_url, notice: 'Snipp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def subscreens
    @snipp = Snipp.find(params[:id])
    render :partial => 'snipp', :layout => false
  end

  private
    def set_snipp
      @snipp = Snipp.find(params[:id])
    end

    def snipp_params
      params.require(:snipp).permit(:title, :html_code, :css_code, :js_code, :user_id)
    end
end