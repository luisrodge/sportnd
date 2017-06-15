class ApplicationController < ActionController::Base
	include Pundit
	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	protect_from_forgery with: :exception

	def after_sign_in_path_for(resource_or_scope)
    if resource.sign_in_count == 1
       profile_after_signup_path
    else
       root_path
    end
	end

	def pundit_user
	  current_member
	end

	protected

	def user_not_authorized
	  flash[:warning] = "You are not authorized to perform this action."
	  redirect_to(request.referrer || root_path)
	end

end
