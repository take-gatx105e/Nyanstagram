class CatImagesController < ApplicationController
  before_action :require_user_logged_in

  before_action do
    @cat = current_user.cats.find(params[:cat_id])
  end

  def index
    @images = @cat.images.order(:position)
  end

  def show
    redirect_to action: "edit"
  end

  def new
    @image = @cat.images.build
  end

  def create
    @image = @cat.images.build(image_params)
    if @image.save
      flash[:success] = '画像の投稿に成功しました。'
      redirect_to [@cat, :images]
    else
      flash.now[:danger] = '画像の投稿に失敗しました。'
      render :new
    end
  end

  def edit
    @image = @cat.images.find(params[:id])
  end

  def update
    @image = @cat.images.find(params[:id])
    @image.assign_attributes(image_params)
    if @image.save
      flash[:success] = '画像の更新に成功しました。'
      redirect_to [@cat, :images]
    else
      flash.now[:danger] = '画像の更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @image = @cat.images.find(params[:id])
    @image.destroy
    flash[:success] = '画像の削除に成功しました。'
    redirect_to [@cat, :images]
  end

  # 表示位置を上げる
  def move_higher
    @image = @cat.images.find(params[:id])
    @image.move_higher
    redirect_back fallback_location: [@cat, :images]
  end

  # 表示位置を下げる
  def move_lower
    @image = @cat.images.find(params[:id])
    @image.move_lower
    redirect_back fallback_location: [@cat, :images]
  end

  private
  
  def image_params
    params.require(:image).permit(
      :new_profile_cat_image,
      :alt_text
    )
  end
end
