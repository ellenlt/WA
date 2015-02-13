class UsersController < ApplicationController
	def index
  		@users = User.all()
  	end

	#Displays simple login form where user can enter login name
	def login
  		#If a user is already logged in, redirects to their page
		if logged_in?
			redirect_to(:controller => :photos, :action => :index, :id => current_user_id)
		end	
	end

  	def post_login
  		if logged_in?
  			flash[:error] = "You are already logged in as #{current_user_full_name}"
  			redirect_to(:controller => :photos, :action => :index, :id => session[:current_user_id])
  		else
	  		current_user = User.find_by_login(params[:login])
				if(current_user != nil) then
		  		# Upon successful login, stores user id in session where it can be checked by other code and
		  		# redirects to the page displaying the user's photos.
		  			session[:current_user_id] = current_user.id
		  			flash[:success] = "Welcome, #{current_user_first_name}!"
		  			redirect_to(:controller => :photos, :action => :index, :id => session[:current_user_id])
		  		else
	  			# If no user exists with the given login, redisplay login form with error message.
	  				flash[:error] = "Invalid username"
	  				redirect_to(:action => :login)
	  			end
	  	end
  	end

  	def logout
  	#Logs user out by clearing information stored in session.
  	#URL redirects back to login page
  		if !logged_in?
  			flash[:error] = "You are already logged out"
  			redirect_to(:action => :login)
  		else
	  		reset_session
	  		flash[:success] = "You have been logged out"
	  		redirect_to(:action => :login)
	  	end
 	end

end