class UsersController < ApplicationController
	def index
  		@users = User.all()
  	end

	# Login form
	# If a user is already logged in, redirects to their page
	def login
		if logged_in?
			redirect_to(:controller => :photos, :action => :index, :id => current_user_id)
		end	
	end

	# Logs in the user
  	def post_login
  		if logged_in?
  			flash[:error] = "You are already logged in as #{current_user_full_name}"
  			redirect_to(:controller => :photos, :action => :index, :id => session[:current_user_id])
  		else
	  		current_user = User.find_by_login(params[:login])
				if(current_user == nil) then
					# If no user exists with the given login, redisplay login form with error message.
	  				flash[:error] = "Invalid username"
	  				redirect_to(:action => :login)
				elsif(!current_user.password_valid?(params[:password])) then
					# If incorrect password, display error message
					flash[:error] = "Invalid password"
	  				redirect_to(:action => :login)
				else
			  		# Upon successful login, stores user id in session where it can be checked by other code and
			  		# redirects to the page displaying the user's photos.
		  			session[:current_user_id] = current_user.id
		  			flash[:success] = "Welcome, #{current_user_first_name}!"
		  			redirect_to(:controller => :photos, :action => :index, :id => session[:current_user_id])
	  			end
	  	end
  	end

  	# Logs out the user and redirects to login page
  	def logout
  		# If already logged out, displays message
  		if !logged_in?
  			flash[:error] = "You are already logged out"
  			redirect_to(:action => :login)
  		else
	  		reset_session
	  		flash[:success] = "You have been logged out"
	  		redirect_to(:action => :login)
	  	end
 	end

 	# New user registration form
  	def new
      if logged_in?
        flash[:error] = "Logout before creating an account!"
        redirect_to(:controller => :photos, :action => :index, :id => session[:current_user_id])
      else
    		@user = User.new()
      end
  	end

  	# Registers new user
  	def create
      if logged_in?
        flash[:error] = "Logout before creating an account!"
        redirect_to(:controller => :photos, :action => :index, :id => session[:current_user_id])
        return
      end

  		new_user = User.new(user_params(params[:user]))

  		# Create new user and redirect to login page
  		if new_user.save
  			flash[:success] = "Congratulations! You've created a new account!"
  			redirect_to(:action => :login)
  		else
  			new_user.errors.full_messages.each do |mess|
  				flash[:error] = mess
  			end
  			redirect_to(:action => :new)
  		end
  	end

    # Form for user to change his or her password
    def password
        if !logged_in?
          flash[:error] = "Must log in to change password"
          redirect_to(:action => :login)
        else
          @user = User.find(current_user_id)
        end
    end

    # Allows user to change his or her password
    def change_password
      #if not logged in, display error message
      if !logged_in?
          flash[:error] = "Must log in to change password"
          redirect_to(:action => :login)
      else
        current_user = User.find(current_user_id)
        if current_user.update(user_params(params[:user])) then
          reset_session
          flash[:success] = "Password successfully updated"
          redirect_to(:action => :login)
        else
          current_user.errors.full_messages.each do |mess|
            flash[:error] = mess
          end
          redirect_to(:action => :password)
        end
      end
    end


 	private
  	def user_params(params)
  		return params.permit(:first_name, :last_name, :login, :password_digest, 
  			:password, :password_confirmation, :password_virtual_attr)
    end

end