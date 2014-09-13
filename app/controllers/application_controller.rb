class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource) # redirect to projects index after signin
    projects_path
  end

	def current_project
    return unless session[:project_id]
    @current_project ||= Project.find(session[:id])
	end

end
