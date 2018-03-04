class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def index
    if logged_in?
      @user = current_user
      @task = current_user.tasks.build
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
    end
  end
  
  def show
    correct_user
  end
  def new
    @task = Task.new
  end
  
  def create

    @task = current_user.tasks.build(task_params)
    @task.user = current_user

    if @task.save
      flash[:success] = 'タスクが作成されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが作成されませんでした'
      render :new
  end
end
  
  def edit
    correct_user
  end
  
  def update
    correct_user
    
    if @task.update(task_params)
      flash[:success] = 'タスクを編集しました'
      redirect_to @task
    else
      flash.now[:danger] = "タスクを編集できませんでした"
      render :edit
  end
end
  
  def destroy
    correct_user
    
    @task.destroy
    
    flash[:success] = "タスクは削除されました"
    redirect_to tasks_url
  end
  
  private
  
  # Strong Parameter

  
  def task_params
    params.require(:task).permit(:content, :status)
    
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
    redirect_to root_url
  end
end
end
