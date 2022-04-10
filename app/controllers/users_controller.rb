class UsersController < ApplicationController

  def new
    # @user = User.new
  end

  def create
    # user = User.new(name: params[:name], email: params[:email])
    user = User.new(user_params)

    if user.save
      # redirect_to "/users/#{user.id}"
      session[:user_id] = user.id
      redirect_to "/dashboard"
    else
      redirect_to "/register"
      flash[:alert] = "ERROR: #{error_message(user.errors)}"
    end
  end

  def show
    @user = User.find(session[:user_id])
  end

  def discover
    @user = User.find(session[:user_id])
  end

  def movies
    @user = User.find(session[:user_id])

    if params[:q] == 'top rated'
      @movies = MovieFacade.top_movies
    elsif params[:q] == 'keyword'
      @movies = MovieFacade.lookup(params[:keyword])
    end
  end

  def movie_show
    @user = User.find(session[:user_id])
    @movie = MovieFacade.details(params[:movie_id])
  end

  # def login_form
  # end
  #
  # def login_user
  #   user = User.find_by(email: params[:email])
  #
  #   if user == nil
  #     redirect_to "/login"
  #     flash[:alert] = "ERROR: Email not found"
  #   elsif user.authenticate(params[:password])
  #     redirect_to "/users/#{user.id}"
  #   else
  #     redirect_to "/login"
  #     flash[:alert] = "ERROR: Incorrect password"
  #   end
  # end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
