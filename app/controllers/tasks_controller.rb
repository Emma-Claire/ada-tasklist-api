class TasksController < ApplicationController
  def index
    render json: {
      count: Task.count,
      tasks: Task.all.as_json(only: [:id, :title, :description, :complete])
    }
  end

  def show
    begin
      task = Task.find(params[:id])
      render json: task.as_json(only: [:id, :title, :description, :complete])
    rescue ActiveRecord::RecordNotFound
      render status: :not_found, content: false
    end
  end

  def create
    task = Task.new(task_params)
    if task.save
      render status: :created, json: {id: task.id}
    else
      render status: :bad_request, json: {
        errors: task.errors.messages
      }
    end
  end

  def update
    begin
      task = Task.find(params[:id])
      task.assign_attributes(task_params)
      if task.save
        render status: :no_content, content: false
      else
        render status: :bad_request, json: {
          errors: task.errors.messages
        }
      end
    rescue ActiveRecord::RecordNotFound
      render status: :not_found, content: false
    end
  end

  def destroy
    begin
      task = Task.find(params[:id])
      task.destroy
      render status: :no_content, content: false
    rescue ActiveRecord::RecordNotFound
      render status: :not_found, content: false
    end
  end

private
  def task_params
    params.require(:task).permit(:title, :description, :complete)
  end
end
