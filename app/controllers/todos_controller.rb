class TodosController < ApplicationController
  before_action :set_todo, only: [:edit, :update, :show, :destroy]
  before_action :set_categories, only: [:index, :new, :edit, :create, :update]

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to todos_path, notice: "To-Do item successfully added" }
        format.turbo_stream { redirect_to todos_path, notice: "To-Do item successfully added" }
      else 
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @todo.save(todo_params)
        format.html { redirect_to todos_path, notice: "To-Do item successfully added" }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to todos_path, notice: "To-Do item successfully destroyed" }
    end
  end

  def index
    @complete_asc = true
    @todos = Todo.order(:complete, created_at: :desc)
    @statuses = ["Pending", "Complete"]

    if params[:status]
      status = params[:status]
      case status
      when "Pending"
        @todos = @todos.where(completed_at: nil).order(created_at: :desc)
      when "Complete"
        @todos = @todos.where(complete: true).order(completed_at: :desc)
      end
    end

    if params[:search].present?
      terms = params[:search]
      @todos = @todos.where("title LIKE ? OR description LIKE ?", "%#{terms}%", "%#{terms}%").order(:complete, created_at: :desc)
    end

    if params[:category].present?
      category = params[:category]
      @todos = @todos.where("category = ?", category).order(:complete, created_at: :desc)
    end


  end

  def add_note
  end
  
  def complete
    @todo = Todo.find(params[:todo_id])

    if @todo.complete
      @todo.completed_at = nil
      @todo.complete = false
    else
      @todo.completed_at = DateTime.now
      @todo.complete = true
    end

    respond_to do |format|
      if @todo.save
        format.html { redirect_to todos_path, notice: "To-Do completed" }
        format.turbo_stream { render :complete }
      end
    end
  end

  private 

  def todo_params
    params.require(:todo).permit(:title, :description, :completed_at, :target_date, :category)
  end 

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def set_categories
    @categories = Todo.categories.map{|index, val| [index.titleize, val]}
  end
end
