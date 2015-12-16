class FeaturedContentsController < ApplicationController
  before_action :require_management_permission
  before_action :set_featured_content, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @featured_contents = FeaturedContent.order(:updated_at).page  params[:page]
  end

  def show
  end

  def new
    @featured_content = FeaturedContent.new
  end

  def edit
  end

def create
    @featured_content = FeaturedContent.new(featured_content_params)
    flash[:notice] = 'The featured content was successfully created.' if @featured_content.save
    respond_with(@featured_content)
  end

  def update
    flash[:notice] = 'The featured content was successfully updated.' if @featured_content.update(featured_content_params)
    respond_with(@featured_content)
  end

  def destroy
    @featured_content.destroy
    respond_with(@featured_contents)
  end

  private
    def set_featured_content
      @featured_content = FeaturedContent.find(params[:id])
    end

    def featured_content_params
      params.require(:featured_content).permit(:preview_image, :description, :title, :published, :url)
    end

    def require_management_permission
      authorize! :manage, FeaturedContent
    end
end
