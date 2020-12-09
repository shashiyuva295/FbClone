class UsersController < ApplicationController

	def show

		@user = User.find(params[:id])
		@users = User.all
		
	end

	def following
		@title = "Following"
		@user = User.find(params[:id])
		@users = @user.followed_users
		redirect_to user_path
	end

	def followers
		@title = "Followers"
		@user = User.find(params[:id])
		@users = @user.followers
		redirect_to user_path
		
	end

	def follow
	    @user = User.find(params[:id])
	    current_user.followees << @user
	    redirect_to user_path(@user)

	end  

	def unfollow
	    @user = User.find(params[:id])
	    current_user.followed_users.find_by(followee_id: 
	        @user.id).destroy
	    redirect_to user_path(@user)
	  end


	# def suggestion
	# 	@user = User.find(params[:id])
	#  	@users = Users.all
	# end


	def facebook
		@user = User.from_omniauth(request.env["omniauth.auth"])
		if @user.persisted?
			sign_in_and_redirect @user, :event => :authentication
			set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
		else
			session["devise.facebook_data"] = request.env["omniauth.auth"]
			redirect_to new_user_registration_url
		end
	end
	
	def failure
		redirect_to root_path
	end


end
