class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.order(created_at: :desc).page(params[:page])
  end
  def show
  end
  def new
    @task = current_user.tasks.build
  end
  def edit
  end
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = "Message が正常に投稿されました."
      redirect_back(fallback_location: @task)
    else
      @tasks = current_user.tasks.order(created_at: :desc).page(params[:page])
      flash.now[:danger] = "Message が投稿されませんでした."
      render 'topages/index'
    end
  end
  def update
    if @task.update(task_params)
      flash[:success] = "Message は正常に更新されました."
      redirect_to @task
    else
      flash.now[:danger] = "Message は更新されませんでした."
      render :edit
    end
  end
  def destroy
    @task.destroy
    flash[:success] = "Message は正常に削除されました."
    redirect_back(fallback_location: root_url)
  end

  private
    def set_task
      @task = current_user.tasks.find_by(id: params[:id])
      unless @task
        redirect_to root_url
      end
    end
    def task_params
      params.require(:task).permit(:content, :status)
    end
end
