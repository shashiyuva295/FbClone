class FollowcountController < ApplicationController
  def follow
  	@current_user.follow(@user)
  	@follow = Follow.find_by(follower: @current_user, followable: @user)

  	respond_to do |format|
  			    # format.html
  			    # format.json  { render :json => @users }
  			    format.js	
  			end
  end

  def unfollow
  	@current_user.stop_following(@user)

  	respond_to do |format|
  			    # format.html
  			    # format.json  { render :json => @users }	
  			    format.js
  			end
  end
end
