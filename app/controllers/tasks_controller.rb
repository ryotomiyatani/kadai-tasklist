class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = 'タスクが作成されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが作成されませんでした'
      render :new
  end
end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  private
  
  # Strong Parameter
  
  def task_params
    params.require(:task).permit(:content)
    
  end
end