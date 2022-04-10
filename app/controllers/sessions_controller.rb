class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user == nil
      redirect_to "/login"
      flash[:alert] = "ERROR: Email not found"
    elsif user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}"
      redirect_to "/dashboard"
    else
      redirect_to "/login"
      flash[:alert] = "ERROR: Incorrect password"
    end
  end

  def destroy
    session.destroy
    redirect_to "/"
  end
end
