class UsersController < ApplicationController

  before_action :require_user, only: :show

  def new
  end

  def create
    user = User.new(user_params)

    if user.save
      session[:user_id] = user.id
      redirect_to "/dashboard"
    else
      redirect_to "/register"
      flash[:alert] = "ERROR: #{error_message(user.errors)}"
    end
  end

  def show
    @user = current_user
  end

  def discover
    @user = current_user
  end

  def movies
    @user = current_user

    if params[:q] == 'top rated'
      @movies = MovieFacade.top_movies
    elsif params[:q] == 'keyword'
      @movies = MovieFacade.lookup(params[:keyword])
    end
  end

  def movie_show
    @user = current_user
    @movie = MovieFacade.details(params[:movie_id])
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
