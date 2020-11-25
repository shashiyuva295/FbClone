class PostsController < ApplicationController
	before_action :authenticate_user!

	def new
		@post = Post.new
	end
	
	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id
		@posts = current_user.posts
	 	if @post.save
		 		redirect_to @post
	 	else
	 		render 'new'
	 	end
	end

	def index
		@post = Post.new
	 	@posts = Post.all
	 	#@notifications = @target.notifications
	end
		
	def show
	 	@post = Post.find(params[:id])
	end
		
	def edit
		@post = Post.find(params[:id])
	end
		
	def update
		@post = Post.find(params[:id])
		
		if @post.update(post_params)
 	    	redirect_to @post
	 	else
	 	    render 'edit'
	 	end
	end
		
	def destroy
	 	@post = Post.find(params[:id])
	 	@post.destroy
		redirect_to posts_path
	end

	private
		def post_params
	    	params.require(:post).permit(:text)
	   	end

end

