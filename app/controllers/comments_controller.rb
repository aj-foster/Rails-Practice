class CommentsController < ApplicationController

	before_filter :authenticate_user!

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(comment_params)
		@comment.author = current_user

		if @comment.save
			redirect_to post_path(@post), notice: 'Comment added.'
		else
			redirect_to post_path(@post), notice: 'Your comment could not be added.'
		end
	end


	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])

		if can? :destroy, @comment
			@comment.destroy
			redirect_to post_path(@post), notice: 'Comment deleted.'
		else
			redirect_to post_path(@post), notice: "You aren't allowed to delete that comment."
		end
	end


	private

		def comment_params
			params[:comment].permit(:body)
		end
end