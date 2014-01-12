class UsersController < ApplicationController

	before_filter :authenticate_user!, except: [:show, :index]

	def show
		@user = User.find(params[:id])
		@posts = @user.posts.limit(2).order(created_at: :desc)
		@comments = @user.comments.limit(2).order(created_at: :desc)
	end
end