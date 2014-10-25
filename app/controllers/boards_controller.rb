class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]

  # GET /boards
  # GET /boards.json
  def index
    @project = Project.find(params[:project_id])
    @boards = Board.find(params[:project_id])
  end

  # GET /boards/1
  # GET /boards/1.json
  def show
    @project = Project.find(params[:project_id]) # do i need this, or is association enough?

  end

  # GET /boards/new
  def new
    @project = Project.find(params[:project_id]) # do i need this, or is association enough?
    @board = @project.boards.build
  end

  # GET /boards/1/edit
  def edit
    @project = Project.find(params[:project_id])
  end

  # POST /boards
  # POST /boards.json
  def create

    @project = Project.find(params[:project_id])
    @board = @project.boards.build(board_params)

    if @board.save
      redirect_to @project, notice: 'Board was successfully created.'
    else
      render action: 'new'
    end

  end

  def update
    if @board.update(board_params)
      redirect_to project_board_path, notice: 'board was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy
    @board.destroy
    @project = Project.find(params[:project_id]) # is there a better way to do this? Is this dry? Maybe make it another class?
    redirect_to @project, notice: 'board was deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    def correct_user
      @this_user = Project.find(params[:project_id])
      if @this_user.user_id != current_user.id
        redirect_to root_path, notice: "You're not authorized." if @project.nil?
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def board_params
      params.require(:board).permit(:title, :description)
    end
end
