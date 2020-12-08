class PostsController < ApplicationController
	after_action { notify }
	before_action :authenticate_user!
	respond_to :js, :html, :json

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

	 	respond_to do |format|
	 		format.html
	 		format.js { render 'posts/create.js.erb'}
	 	end
	end

	def index
		@post = Post.new
	 	@posts = Post.all
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

	def like

		@post = Post.find(params[:id])

		if params[:value] == 'like'
			@post.liked_by current_user
		elsif params[:value] == 'unlike'
	      	@post.unliked_by current_user
	    end

	    respond_to do |format|
	    	format.html #{render 'posts/show.html.erb'}
	    	format.js { render 'posts/show.js.erb'}
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
	   	
	 	def notify
	   		Notification.create(event: "New Notification")
	   	end


end

