class CatsController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    # @cats = Cat.order(id: :desc).page(params[:page]).per(6)  # 全ての猫
    @cats = current_user.cats.order(id: :desc).page(params[:page]).per(6)  # ログインユーザの猫
    # @cats = current_user.feed_cats.order(id: :desc).page(params[:page]).per(6)  # ログインユーザの猫
  end

  def show
    # @cat = current_user.cats.find(params[:id])
    @cat = Cat.find(params[:id])
  end

  def new
    @cat = current_user.cats.build  # form_with 用
    # @cat = current_user.cats.new
    # @cat = Cat.new
  end

  def create
    @cat = current_user.cats.build(cat_params)
    if @cat.save
      flash[:success] = 'にゃんこ情報を投稿しました。'
      redirect_to @cat
    else
      flash.now[:danger] = 'にゃんこ情報の投稿に失敗しました。'
      render :new
    end
  end

  def edit
    @cat = current_user.cats.find(params[:id])
  end

  def update
    @cat = current_user.cats.find(params[:id])
    if @cat.update(cat_params)
      flash[:success] = 'にゃんこの更新に成功しました。'
      redirect_to @cat
    else
      flash.now[:danger] = 'にゃんこの更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @cat = current_user.cats.find(params[:id])
    @cat.destroy
    flash[:success] = 'にゃんこは正常に削除されました。'
    redirect_to cats_url
  end
  
  private
  
  def cat_params
    params.require(:cat).permit(:catname, :catprofile)
  end
end
