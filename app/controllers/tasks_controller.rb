class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = Task.all
  end

  # gets all of user's tasks
  def index_for_user
    @tasks = current_user.tasks
  end

  # show a specific task
  def show_for_user
    @task = current_user.tasks.find(params[:id])
  end

  # show users tasks for the day
  def today_tasks_for_user
    @today_tasks = current_user.tasks.where(due_date: Date.today)
  end

  # builds a new task from user input in form
  def new_for_user
    @task = current_user.tasks.build
  end
  
  # creates a new task for user
  def create_for_user
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new_for_user
    end
  end

  # populates form with current task info
  def edit_for_user
    @task = current_user.tasks.find(params[:id])
  end

  # updates a task
  def update
    @task = current_user.find(params[:id])
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit_for_user
    end
  end
  
  # mark a task complete
  def complete
    @task = current_user.tasks.find(params[:id])
    @task.update(completed: true)
    redirect_to tasks_url, notice: 'Task marked as complete.'
  end

  # mark a task incomplete
  def incomplete
    @task = current_user.tasks.find(params[:id])
    @task.update(completed: false)
    redirect_to tasks_url, notice: 'Task marked as incomplete.'
  end

  # delete a task
  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  # gets all of a user's completed tasks within a range of dates
  def completed_tasks_by_date_for_user
    if params[:start_date].present? && params[:end_date].present?
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])
      @completed_tasks = current_user.tasks.where(completed: true, due_date: start_date..end_date)
    else
      @completed_tasks = current_user.tasks.where(completed: true)
    end
  end


  # gets all of a user's incomplete tasks within a date range
  def incomplete_tasks_by_date_for_user
    if params[:start_date].present? && params[:end_date].present?
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])
      @incomplete_tasks = current_user.tasks.where(completed: false, due_date: start_date..end_date)
    else
      @incomplete_tasks = current_user.tasks.where(completed: false)
    end
  end

  
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:title, :description, :due_date, :completed)
  end


  end
  