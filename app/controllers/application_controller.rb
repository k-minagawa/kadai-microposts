class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def require_anonymous_user
    if logged_in?
      redirect_to root_url
    end
  end
  
  def microposts_counts(user)
    user.microposts.count
  end
  
  def followings_counts(user)
    user.followings.count
  end
  
  def followers_counts(user)
    user.followers.count
  end
  
  def likings_counts(user)
    user.liking_microposts.count
  end
  
end
