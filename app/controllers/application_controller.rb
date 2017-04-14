class ApplicationController < ActionController::Base
	include Pundit

	protect_from_forgery with: :exception

	before_action :configure_permitted_parameters, if: :devise_controller?

	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	protected

	def user_not_authorized
	  flash[:warning] = "You are not authorized to perform this action."
	  redirect_to(request.referrer || root_path)
	end

	def configure_permitted_parameters
    	devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :full_name, :profile_image, :email, :password, :password_confirmation) }
	end
end
