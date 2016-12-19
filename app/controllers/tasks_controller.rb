class TasksController < ApplicationController
  def index
    send_data(data: {
      count: Task.count,
      tasks: Task.all.as_json(only: [:id, :title, :description, :completed])
    })
  end

  def show
    begin
      task = Task.find(params[:id])
      send_data task.as_json(only: [:id, :title, :description, :completed])
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
    params.require(:task).permit(:title, :description, :completed)
  end

  def send_data(data, status=:success)
    respond_to do |format|
      format.js { render :status => status, :json => data, :callback => params[:callback] }
      format.json { render :status => status, :json => data }
      format.xml { render :status => status, :xml => data }
    end
  end
end
