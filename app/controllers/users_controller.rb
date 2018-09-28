class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @tasklists = @user.tasklists.order('created_at DESC').page(params[:page])
    counts(@user)
  end
  
  def edit
  end
  
  
  
  def update
    if @tasklist.update(tasklist_params)
      flash[:success] = 'タスク は正常に更新されました'
      redirect_to @tasklist
    else
      flash.now[:danger] = 'タスク は更新されませんでした'
      render :edit
    end
  end

  def new
    @user = User.new
  end

  def create
    
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
