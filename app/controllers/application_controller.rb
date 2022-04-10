class ApplicationController < ActionController::Base
  private

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    if !current_user
      flash[:alert] = 'You must be logged-in to do that!'
      redirect_to '/'
    end
  end

  def error_message(errors)
    errors.full_messages.join(', ')
  end

end
