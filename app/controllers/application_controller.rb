class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :instantiate_action_javascript

  def instantiate_action_javascript
    js_path = File.join(controller_path, "#{action_name}.js")
    @current_action_javascript_path = File.exist?(File.join(RAILS_ROOT, 'public', 'javascripts', js_path)) ? js_path : nil
  end
end
