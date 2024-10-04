class TodosController < ApplicationController
  def new
    @todo = Todo.new
    @categories = Todo.categories.map{|index, val| [index.titleize, val]}
  end

  def create
    @todo = Todo.new(todo_params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to todos_path, notice: "To-Do item successfully added" }
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
  end

  def destroy
  end

  def index
    @todos = Todo.order(created_at: :desc)
  end

  def add_note
  end

  private 

  def todo_params
    params.require(:todo).permit(:title, :description, :completed_at, :target_date, :category)
  end 
end
