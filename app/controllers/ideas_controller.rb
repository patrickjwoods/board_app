class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :edit, :update, :destroy]

  # GET /ideas
  # GET /ideas.json
  def index
    @ideas = Idea.all
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
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
  end

  # POST /ideas
  # POST /ideas.json
  def create

    # @project = Project.find(params[:project_id])
    @project = Project.find(params[:project_id]) # do i need this, or is association enough?
    @board = Board.find(params[:board_id])
    @idea = @board.ideas.build(idea_params)


    if @idea.save
      redirect_to @project, notice: 'Idea was successfully created.' #this redir to project, needs to be Board#index
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
    redirect_to [@project,@board], notice: 'Idea was successfully destroyed.'

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = Idea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def idea_params
      params.require(:idea).permit(:url, :image, :board_id)
    end
end
