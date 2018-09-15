class SessionsController < ApplicationController
  before_action :require_anonymous_user, only: [:new, :create]
  
  def new
  end

  def create
    email = params[:sessions][:email].downcase
    password = params[:sessions][:password]
    if login(email, password)
      flash[:success] = "ログインしました。"
      redirect_to @user
    else
      flash[:danger] = "ログインに失敗しました。"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "ログアウトしました。"
    redirect_to root_path
  end
  
  private
  
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      return true
    else
      return false
    end
  end
end
