class ProjectsController < ApplicationController
  before_action :set_project, only: [:edit, :update, :show, :destroy]
  before_action :set_categories, only: [:index, :new, :edit, :create, :update]


  def add_todo
  end

  def new
    @project = Project.new
    if params[:type].present? 
      @type = params[:type]
    end
  end

  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path, notice: "To-Do item successfully added" }
        format.turbo_stream { redirect_to projects_path, notice: "To-Do item successfully added" }
      else 
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to projects_path, notice: "To-Do item successfully added" }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_path, notice: "To-Do item successfully destroyed" }
    end
  end

  def index
    @complete_asc = true
    @projects = Project.order(:complete, created_at: :desc)
    @statuses = ["Pending", "Complete"]

    if params[:status]
      status = params[:status]
      case status
      when "Pending"
        @projects = @projects.where(completed_at: nil).order(created_at: :desc)
      when "Complete"
        @projects = @projects.where(complete: true).order(completed_at: :desc)
      end
    end

    if params[:search].present?
      terms = params[:search]
      @projects = @projects.where("title LIKE ? OR description LIKE ?", "%#{terms}%", "%#{terms}%").order(:complete, created_at: :desc)
    end

    if params[:category].present?
      category = params[:category]
      @projects = @projects.where("category = ?", category).order(:complete, created_at: :desc)
    end


  end

  def complete
    @project = Project.find(params[:project_id])

    if @project.complete
      @project.completed_at = nil
      @project.complete = false
    else
      @project.completed_at = DateTime.now
      @project.complete = true
    end

    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path, notice: "To-Do completed" }
        format.turbo_stream { render :complete }
      end
    end
  end

  private 

  def project_params
    params.require(:project).permit(:title, :description, :completed_at, :target_date, :category)
  end 

  def set_project
    @project = Project.find(params[:id])
  end

  def set_categories
    @categories = Todo.categories.map{|index, val| [index.titleize, val]}
  end
end
