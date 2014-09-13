class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]

  # GET /boards
  # GET /boards.json
  def index
    @boards = Board.find(params[:project_id])
  end

  # GET /boards/1
  # GET /boards/1.json
  def show
  end

  # GET /boards/new
  def new
    @project = Project.find(params[:project_id])
    @board = @project.boards.build
  end

  # GET /boards/1/edit
  def edit
  end

  # POST /boards
  # POST /boards.json
  def create
    @project = Project.find(params[:project_id])
    @board = @project.boards.build(params[:board])

    if @board.save
      redirect_to @project, notice: 'Board was successfully created.'
    else
      render action: 'new'
    end
    
  end

  def update
    if @board.update(board_params)
      redirect_to @board, notice: 'board was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy
    @board.destroy
    redirect_to boards_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def board_params
      params.require(:board).permit(:title, :description, :project_id)
    end
end
