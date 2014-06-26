class SnippsController < ApplicationController
  before_action :set_snipp, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :only => [:new, :edit, :update, :destroy]
  before_action :authorize, :only => [:edit, :update, :destroy]

  def index
    if params[:tag]
      @snipps = Snipp.tagged_with(params[:tag]).search(params[:search], params[:page])
    else
      @snipps = Snipp.search(params[:search], params[:page])
    end
  end

  def show
    @snipp = Snipp.find(params[:id])
    @snipp.html_code = CodeRay.scan(@snipp.html_code, :html).div(:line_numbers => :table) if @snipp.html_code.present?
    @snipp.css_code = CodeRay.scan(@snipp.css_code, :css).div(:line_numbers => :table) if @snipp.css_code.present?
    @snipp.js_code = CodeRay.scan(@snipp.js_code, :java_script).div(:line_numbers => :table) if @snipp.js_code.present?
    Visit.track(@snipp, request.remote_ip)
  end

  def new
    @snipp = Snipp.new
    @tags_list = TagsHelper.get_tags
  end

  def edit
  end

  def create
    @snipp = Snipp.new(snipp_params)
    @snipp.user_id = current_user.id

    respond_to do |format|
      if @snipp.save
        format.html { redirect_to @snipp, flash: { success: 'Snipp was successfully created.' } }
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
        format.html { redirect_to @snipp, flash: { notice: 'Snipp was successfully updated.' } }
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
    @snipp.html_code = ActionController::Base.helpers.sanitize(@snipp.html_code, :tags => Snipp.html_tags, :attributes => Snipp.html_attributes)
    render :partial => 'snipp', :layout => false
  end

  def tags
    @tags = TagsHelper.get_tags
  end

  def user_snipps
    if params[:user]
      @user = User.find(params[:user])
      @snipps = Snipp.where(user_id: @user.id).search(params[:search], params[:page])
    else
      @snipps = current_user.snipps.search(params[:search], params[:page])
      render 'snipps/index'
    end
  end

  private
    def set_snipp
      @snipp = Snipp.find(params[:id])
    end

    def snipp_params
      params.require(:snipp).permit(:title, :html_code, :css_code, :js_code, :user_id, tag_list: [])
    end
    def authorize
      unless @snipp.owner?(current_user)
        redirect_to root_url, flash: { alert: "Unauthorize" }
      end
    end
end
