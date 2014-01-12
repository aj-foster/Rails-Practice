class PostsController < ApplicationController

	before_filter :authenticate_user!, except: [:show, :index]

	def index
		@posts = Post.all.sort_by {|e| e.created_at}.reverse
	end


	def show
		@post = Post.find(params[:id])
	end


	def new
		@post = Post.new
	end


	def create
		@post = Post.new(post_params)
		@post.author = current_user

		if @post.save
			redirect_to @post, notice: 'Post Created.'
		else
			render 'new'
		end
	end


	def destroy
		@post = Post.find(params[:id])

		if can? :destroy, @post
			@post.destroy
			redirect_to post_path, notice: 'Post deleted.'
		else
			redirect_to post_path(@post), notice: "You aren't allowed to delete that post."
		end
	end


	private

		def post_params
			params.require(:post).permit(:title, :body)
		end
end