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

	def import

		User.import(params[:file])
		#after the import, redirect and let us know the method is working!
		redirect_to root_url, notice: "Activity Data imported"
	end
end