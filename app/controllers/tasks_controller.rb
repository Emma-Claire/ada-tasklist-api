class TasksController < ApplicationController
  def index
    render json: {
      count: Task.count,
      tasks: Task.all.as_json(only: [:id, :title, :description, :completed])
    }
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end
end
