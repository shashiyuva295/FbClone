class ApplicationController < ActionController::Base
	before_action :session_user
	before_action :configure_permitted_parameters, if: :devise_controller? 

	#before_action :authorized?
	   
	def session_user
		@user_id = session[:user_id]
	    @logged_in = !!@user_id      

	    if @logged_in
	    	@current_user = User.find(@user_id)
		end
	end   

	#def authorized?
	    #unless @logged_in
	         #return redirect_to new_session_path
	    #end
	#end   

	def logout
	    session[:user_id] = nil
	end

	protected

	def configure_permitted_parameters
	  devise_parameter_sanitizer.permit(:sign_up,
	    keys: [:user_name, :email, :password, :password_confirmation])
	  devise_parameter_sanitizer.permit(:sign_in,
	    keys: [:login, :password, :password_confirmation])
	  devise_parameter_sanitizer.permit(:account_update,
	    keys: [:user_name, :email, :password_confirmation, :current_password])
	end
	
end
