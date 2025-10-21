class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [ :show, :edit, :update, :destroy, :toggle_complete ]
  before_action :set_all_operators, only: [ :new, :edit, :create, :update ]

  def index
    # All users can see all tasks, ordered by latest first
    @tasks = Task.order(created_at: :desc)
    @task = Task.new
  end

  def show
    @comment = Comment.new
  end

  def new
    @task = Task.new
    @all_operators = [ "John Doe", "Jane Smith", "Michael", "Sarah" ] # example names
  end

  def create
  @task = current_user.tasks.build(task_params)
  if @task.save
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @task, notice: "Task created successfully." }
    end
  else
    render :new, status: :unprocessable_entity
  end
  end

  def edit
   @all_operators = [ "John Doe", "Jane Smith", "Michael", "Sarah" ] # same here
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: "Task updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = "Task deleted successfully."
      end
      format.html { redirect_to tasks_path, notice: "Task deleted successfully." }
    end
  end

  def toggle_complete
    @task.update(completed: !@task.completed)
    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = @task.completed? ? "Task marked as complete." : "Task marked as incomplete."
      end
      format.html { redirect_to tasks_path }
    end
  end

  private

  def set_task
    # Any user can access any task
    @task = Task.find(params[:id])
  end

  def set_all_operators
    @all_operators = [ "John Doe", "Jane Smith", "Michael", "Sarah" ]
  end

  def task_params
    params.require(:task).permit(:title, :description, :completed,
      operators_attributes: [ :id, :name, :role, :_destroy ])
  end
end
