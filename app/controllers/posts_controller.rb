class PostsController < ApplicationController

	before_filter :authenticate_user!, except: [:show, :index]

	def index
		@posts = Post.order(created_at: :desc).page(params[:page])
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


	def edit
		@post = Post.find(params[:id])
	end


	def update
		@post = Post.find(params[:id])

		if can? :update, @post
			if @post.update(post_params)
				redirect_to @post, notice: 'Post updated.'
			else
				render 'edit'
			end
		else
			redirect_to @post, notice: "You aren't allowed to edit that post."
		end
	end


	def destroy
		@post = Post.find(params[:id])

		if can? :destroy, @post
			@post.destroy
			redirect_to posts_path, notice: 'Post deleted.'
		else
			redirect_to post_path(@post), notice: "You aren't allowed to delete that post."
		end
	end


	private

		def post_params
			params.require(:post).permit(:title, :body)
		end
end