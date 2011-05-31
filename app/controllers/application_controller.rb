class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"
    redirect_to root_url
  end

  rescue_from Twitter::Unauthorized do |exception|
    if current_user
      if current_user.connected_to_twitter?
        flash[:error] = "There was an error with your Twitter account. We've been notified and will do our best to fix it."
      else
        flash[:error] = "You need to <a href='/user/connect/twitter'>connect to Twitter</a> before you can Tweet quiz questions.".html_safe
      end
    end
    redirect_to :back
  end
end
