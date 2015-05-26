class FeaturedBoardsController < ApplicationController
  before_action :require_management_permission, except: [:preview]
  before_action :set_featured_board, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def preview
    @featured_board = FeaturedBoard.create(title: '', url: params[:url])
    render 'preview'
  end

  def index
    @featured_boards = FeaturedBoard.all
    respond_with(@featured_boards)
  end

  def show
    @seconds_to_expiration = seconds_to_expiration
    respond_with(@featured_board)
  end

  def new
    @featured_board = FeaturedBoard.new
    respond_with(@featured_board)
  end

  def edit
  end

  def create
    @featured_board = FeaturedBoard.new(featured_board_params)
    flash[:notice] = 'The featured image was successfully created.' if @featured_board.save
    respond_with(@featured_board)
  end

  def update
    flash[:notice] = 'The featured image was successfully updated.' if @featured_board.update(featured_board_params)
    respond_with(@featured_board)
  end

  def destroy
    @featured_board.destroy
    respond_with(@featured_board)
  end

  private
    def set_featured_board
      @featured_board = FeaturedBoard.find(params[:id])
    end

    def featured_board_params
      params.require(:featured_board).permit(:title, :url, :published, :seconds_to_expiration)
    end

    def require_management_permission
      authorize! :manage, FeaturedBoard
    end
end
