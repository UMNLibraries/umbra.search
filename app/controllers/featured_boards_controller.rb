class FeaturedBoardsController < ApplicationController
  before_action :require_management_permission
  before_action :set_featured_board, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @featured_boards = FeaturedBoard.all
    respond_with(@featured_boards)
  end

  def show
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
      params.require(:featured_board).permit(:title, :url, :published)
    end

    def require_management_permission
      authorize! :manage, FeaturedBoard
    end
end
