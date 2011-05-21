class ApplicationController < ActionController::Base
	#include Twitter::Login::Helpers
  #protect_from_forgery
	before_filter :authenticate_user!
	#before_filter { |c| c.set_twitter_access_tokens!(session) }


	def set_twitter_access_tokens!(session)
		if current_user	
			if twitter_logged_in?
				current_user.access_token_key = session[:twitter_access_token][0]
				current_user.access_token_secret = session[:twitter_access_token][1]
				current_user.save
			end
		end
	end
	
end
