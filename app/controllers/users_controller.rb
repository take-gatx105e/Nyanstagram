class UsersController < ApplicationController
  before_action :require_user_logged_in, except: [:new, :create]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(6)
  end

  def show
    @user = User.find(params[:id])
    @cats = @user.cats.order(id: :desc).page(params[:page]).per(6)
    counts(@user)
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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = 'ユーザの更新に成功しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = 'ユーザは正常に削除されました。'
    redirect_to root_url
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.order(id: :desc).page(params[:page]).per(6)
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.order(id: :desc).page(params[:page]).per(6)
    counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.order(id: :desc).page(params[:page]).per(6)
    counts(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :profile,
      :new_profile_image
    )
  end
end
