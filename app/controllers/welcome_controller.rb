class WelcomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    set_tab :home
  end

end
