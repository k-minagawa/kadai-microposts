class UsersController < ApplicationController
  before_action :require_user_logged_in, except: [:new, :create]
  before_action :require_anonymous_user, only: [:new, :create]
  
  def index
    @users = User.all.page(params[:page]).per(20)
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order('created_at DESC').page(params[:page]).per(7)
    
    @microposts_counts = microposts_counts(@user)
    @followings_counts = followings_counts(@user)
    @followers_counts = followers_counts(@user)
    @likes_counts = likings_counts(@user)
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page]).per(7)
    
    @microposts_counts = microposts_counts(@user)
    @followings_counts = followings_counts(@user)
    @followers_counts = followers_counts(@user)
    @likes_counts = likings_counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page]).per(7)
    
    @microposts_counts = microposts_counts(@user)
    @followings_counts = followings_counts(@user)
    @followers_counts = followers_counts(@user)
    @likes_counts = likings_counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.liking_microposts.page(params[:page]).per(7)
    
    @microposts_counts = microposts_counts(@user)
    @followings_counts = followings_counts(@user)
    @followers_counts = followers_counts(@user)
    @likings_counts = likings_counts(@user)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "新しくユーザー登録されました"
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash.now[:danger] = "ユーザー登録に失敗しました"
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "ユーザーは編集されました"
      redirect_to @user
    else
      flash.now[:danger] = "ユーザー編集に失敗しました"
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "ユーザーは削除されました"
    session[:user_id] = nil
    redirect_to users_path
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :agreement)
  end

end
