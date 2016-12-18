class TasksController < ApplicationController
  def index
    render json: {
      count: Task.count,
      tasks: Task.all.as_json(only: [:id, :title, :description, :completed])
    }
  end

  def show
    begin
      task = Task.find(params[:id])
      render json: task.as_json(only: [:id, :title, :description, :completed])
    rescue ActiveRecord::RecordNotFound
      render status: :not_found, content: false
    end
  end

  def create
  end

  def update
  end

  def destroy
  end
end
