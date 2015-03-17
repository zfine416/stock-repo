class SessionsController < ApplicationController
	before_action :require_current_user, only: :destroy

	def new
		@user = User.new
	end

	def create
		@user = User.find_by(email: session_params[:email])
		if @user && @user.authenticate(session_params[:password])
		login!(@user)
		# Pry.start(binding)
		redirect_to "/users/home"
	else
		redirect_to new_session_path
	end

	end

	def destroy
		logout!
		redirect_to new_session_url
	end
	private

	def session_params
		@session_params ||= params.require(:session).permit(:username, :email, :password)
	end
end
