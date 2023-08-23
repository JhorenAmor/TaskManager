class Api::V1::TasksController < ApplicationController
  before_action :set_task, only: %i[show update destroy move]

  def index
    tasks = Task.all.order(:sort_key)
    render json:tasks, status: 200
  end

  def show
    raise "Task not found!" if @task.blank?
    render json:@task, status: 200
  rescue StandardError => error
    render json: { error: error.message }
  end

  def create
    task = Task.new(task_params)

    if task.save
      render json: task, status: 200, message: "Task created successfully"
    else
      render json: { error: task.errors.messages }, status: :unprocessable_entity
    end
  rescue StandardError => error
    render json: { error: error.message }
  end

  def update
    if @task.update(task_params)
      render json:@task,  status: 200, message: "Task updated successfully."
    else
      render json: { error: @task.errors.message } 
    end
  rescue StandardError => error
    render json: { error: error.message }
  end

  def destroy
    if @task.present?
      @task.destroy!
      render json: { message: "Task deleted successfully." }, status: 200
    else
      render json: { message: "Task not found." }
    end
  rescue StandardError => error
    render json: { error: error.message }
  end

  def move
    new_position = params[:new_position].to_f
    @task.insert_at(new_position)
    render json: { message: 'Task successfully moved.' }, status: :ok
  end

  private

  def set_task
    @task = Task.find_by(id: params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :details, :sort_key)
  end
end
