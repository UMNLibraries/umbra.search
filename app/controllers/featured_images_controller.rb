class FeaturedImagesController < ApplicationController
  before_action :require_management_permission
  before_action :set_featured_image, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @featured_images = FeaturedImage.all
    respond_with(@featured_images)
  end

  def show
    respond_with(@featured_image)
  end

  def new
    @featured_image = FeaturedImage.new
    respond_with(@featured_image)
  end

  def edit
  end

  def create
    @featured_image = FeaturedImage.new(featured_image_params)
    flash[:notice] = 'The featured image was successfully created.' if @featured_image.save
    respond_with(@featured_image)
  end

  def update
    flash[:notice] = 'The featured image was successfully updated.' if @featured_image.update(featured_image_params)
    respond_with(@featured_image)
  end

  def destroy
    @featured_image.destroy
    respond_with(@featured_image)
  end

  private
    def set_featured_image
      @featured_image = FeaturedImage.find(params[:id])
    end

    def featured_image_params
      params.require(:featured_image).permit(:uploaded_image, :remove_uploaded_image, :title, :record_id, :published)
    end

    def require_management_permission
      authorize! :manage, FeaturedImage
    end
end
