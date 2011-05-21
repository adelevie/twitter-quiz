class WelcomeController < ApplicationController
	include ApplicationHelper
	before_filter :authenticate_user!

  def index
  end

end
