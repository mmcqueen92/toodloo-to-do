class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # gets all of user's tasks
  def index
    @tasks = current_user.tasks.all
  end

  # show users tasks for the day
  def today
    @today_tasks = current_user.tasks.where(due_date: Date.today)
  end

  #show users tasks for a given day
  def tasks_for_day
    if params[:date].present?
      @date = Date.parse(params[:date])
      @tasks_for_day = current_user.tasks.where(due_date: @date)
    end
  end

  # toggle a tasks status
  def toggle_status
    @task = Task.find(params[:id])
    @task.update(completed: !@task.completed)
    redirect_to request.referer, notice: 'Task status updated successfully.'

  end

  # new task form
  def new
    @task = current_user.tasks.build
  end

  # creates a new task for user
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  # show a specific task
  def show
    @task = current_user.tasks.find(params[:id])
  end

  # populates form with current task info
  def edit
    @task = current_user.tasks.find(params[:id])
  end

  # updates a task
  def update_for_user
    @task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit_for_user
    end
  end
  
  # delete a task
  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  # gets all of a user's tasks that fit the search params (start date, end date, status)
  def search_user_tasks
    if params[:start_date].present? || params[:end_date].present? || params[:task_status].present?
      start_date = params[:start_date]
      end_date = params[:end_date]
      task_status = params[:task_status]

      tasks = current_user.tasks

      if start_date.present? && end_date.present?
        tasks = tasks.where(due_date: start_date..end_date)
      end

      if start_date.present? && !end_date.present?
        tasks = tasks.where("due_date >= ?", start_date)
      end

      if end_date.present? && !start_date.present?
        tasks = tasks.where("due_date <= ?", end_date)
      end

      if task_status.present? && task_status == 'completed'
        @filtered_tasks = tasks.where(completed: true)
      elsif task_status.present? && task_status == 'incomplete'
        @filtered_tasks = tasks.where(completed: false)
      else
        @filtered_tasks = tasks
      end
    else
      # show all tasks by if no params present
      @filtered_tasks = current_user.tasks
    end
  end


  
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:title, :description, :due_date, :completed)
  end

  def date_param
    params.require(:date).permit(:date)
  end


end
  