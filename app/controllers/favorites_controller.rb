class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    cat = Cat.find(params[:cat_id])
    current_user.favorite(cat)
    flash[:success] = 'お気に入りに登録しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    cat = Cat.find(params[:cat_id])
    current_user.unfavorite(cat)
    flash[:success] = 'お気に入りを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
