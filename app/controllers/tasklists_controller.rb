class TasklistsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show,:destroy,:edit,:update]
  
  def show
  end
 
  def create
    @tasklist = current_user.tasklists.build(tasklist_params)
    if @tasklist.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @tasklists = current_user.tasklists.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end
  
  def edit
  end
  
  def update

    if @tasklist.update(tasklist_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @tasklist
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @tasklist.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def tasklist_params
    params.require(:tasklist).permit(:content, :status)
  end
  
  def correct_user
    @tasklist = current_user.tasklists.find_by(id: params[:id])
    unless @tasklist
      redirect_to root_url
    end
  end
end
