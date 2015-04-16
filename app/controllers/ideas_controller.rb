class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :edit, :update, :destroy]
  #before_action :authenticate_user!
  #before_action :correct_user

  # GET /ideas
  # GET /ideas.json
  def index
    @ideas = Idea.all
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
    @project = Project.find(params[:project_id])
    @board = Board.find(params[:board_id])
  end

  # GET /ideas/new
  def new
#    @project = Project.find(params[:project_id]) # do i need this, or is association enough?
#    @board = @project.boards.build

    @project = Project.find(params[:project_id]) # do i need this, or is association enough?
    @board = Board.find(params[:board_id]) # i think they have to be defined to be called in _forms
    @idea = @board.ideas.build

#    @idea = Idea.new
  end

  # GET /ideas/1/edit
  def edit
    @project = Project.find(params[:project_id])
    @board = Board.find(params[:board_id])
  end

  # POST /ideas
  # POST /ideas.json
  def create

    # @project = Project.find(params[:project_id])
    @project = Project.find(params[:project_id]) # do i need this, or is association enough?
    @board = Board.find(params[:board_id])
    @idea = @board.ideas.build(idea_params)


    if @idea.save
      redirect_to [@project,@board], notice: 'Idea was successfully created.' #this redir to project, needs to be Board#index
    else
      render action: 'new'  
    end

  end

  # PATCH/PUT /ideas/1
  # PATCH/PUT /ideas/1.json
  def update
    respond_to do |format|
      if @idea.update(idea_params)
        format.html { redirect_to @idea, notice: 'Idea was successfully updated.' }
        format.json { render :show, status: :ok, location: @idea }
      else
        format.html { render :edit }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
 
    @project = Project.find(params[:project_id]) # do i need this, or is association enough?
    @board = Board.find(params[:board_id])
   
    @idea.destroy
    redirect_to [@project,@board], notice: 'Idea was successfully deleted.'

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = Idea.find(params[:id])
    end

    def correct_user
      @this_user = Project.find(params[:project_id])
      if @this_user.user_id != current_user.id || current_user.nil?
        redirect_to root_path, notice: "You're not authorized." if @project.nil?
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def idea_params
      params.require(:idea).permit(:url, :image, :image_url, :image_remote_url, :board_id)
    end
end
