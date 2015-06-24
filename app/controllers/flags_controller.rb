class FlagsController < ApplicationController
  before_action :require_management_permission
  before_action :set_flag, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @flags = Flag.all
    respond_with(@flags)
  end

  def show
    respond_with(@flag)
  end

  def new
    @flag = Flag.new
    respond_with(@flag)
  end

  def edit
  end

  def create
    @flag = Flag.new(flag_params)
    flash[:notice] = 'The flag was successfully created.' if @flag.save
    respond_with(@flag)
  end

  def update
    flash[:notice] = 'The featured flag was successfully updated.' if @flag.update(flag_params)
    respond_with(@flag)
  end

  def destroy
    @flag.destroy
    respond_with(@flag)
  end

  private
    def set_flag
      @flag = Flag.find(params[:id])
    end

    def flag_params
      params.require(:flag).permit(:on_text, :off_text, :on_text_display, :off_text_display, :on_css, :off_css, :published, :search_filter_threshold, :restrict_to_editors)
    end

    def require_management_permission
      authorize! :manage, Flag
    end
end
