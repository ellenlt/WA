class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user_first_name
  helper_method :logged_in?

  def current_user_id
  	return session[:current_user_id]
  end

  def current_user_first_name
  	return User.find_by_id(current_user_id).first_name
  end

  def current_user_full_name
  	return User.find_by_id(current_user_id).full_name
  end

  def logged_in?
  	return session[:current_user_id] != nil
  end
end
