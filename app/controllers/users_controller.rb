class UsersController < ApplicationController

	def show
    session[:current_temp] ||= current_temp
    session[:chance_of_rain] ||= chance_of_rain
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_creation_params)
		if @user.save
			session[:user_id] = @user.id
			Wardrobe.find_or_create_by(user: @user)
			redirect_to @user
		else
			render "new"
		end
	end

	private

	def user_creation_params
		params.require(:user).permit(:first_name, :last_name, :email, :password)
	end

end
