class SessionsController < ApplicationController

	def new
	end


	def create
		p params
		p User.all
    @user = User.find_by(email: params[:email])
    if @user.authenticate(params[:password]) #@user && @user.password == params[:password]
      session[:user_id] = @user.id
      redirect_to @user
    else
    	@error = "Invalid email or password"
    	render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:current_temp] = nil
    session[:chance_of_rain] = nil
    redirect_to :root
  end

  def location
    session[:longitude] = params[:longitude].to_f
    session[:latitude]  = params[:latitude].to_f
    render :nothing => true
  end

end
