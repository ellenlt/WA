class PhotosController < ApplicationController
  def index
  	# photos/index/id displays all of the photos belonging to a particular user.
  	# For each photo you must display the photo itself, the creation time for the photo, 
  	# and all of the comments for that photo. For each comment you must display 
  	# time when the comment was created, the name of the user who created the comment, 
  	# and the text of the comment. The creator for each comment should be a link 
  	# that can be clicked to switch to the photos page for that user.
  	@user = User.find_by_id(params[:id])
    if logged_in?
      @current_user = User.find(current_user_id)
    end
  end

  # Form for adding new photos
  def new
  	if !logged_in?
  		flash[:error] = "Must be logged in to upload photos."
        redirect_to(:controller => :users, :action => :login)
 	else
      	@photo = Photo.new()
    end
  end

  # Adds new photo
  def create
  	# Checks if user is logged in
  	if !logged_in?
  		flash[:error] = "Must be logged in to upload photos."
        redirect_to(:controller => :users, :action => :login)
    # Checks if photo was uploaded before submitting
    elsif params[:file] == nil
    	flash[:error] = "Invalid photo"
    	redirect_to(:action => :new)
  	else	
  		# Creates new photo record in database
  		photo = Photo.new()
  		
  		# Saves photo to /app/assets/images/filename
  		photo_file = params[:file]
  		File.open(Rails.root.join('app', 'assets', 'images', photo_file.original_filename), 'wb') do |file|
  	  		file.write(photo_file.read)
  	  end

  		#Saves name of photo file
  	  photo.file_name = photo_file.original_filename
      photo.user_id = session[:current_user_id]
      photo.date_time = DateTime.now

  	  photo.save()
  		redirect_to(:controller => :photos, :action => :index, :id => session[:current_user_id])
	 end
  end

  # Allows a user to delete his or her own photos
  def delete
    if !logged_in?
      flash[:error] = "Must log in to delete photo"
      redirect_to(:action => :login)
    elsif params[:id] and Photo.exists?(params[:id]) and Photo.find(params[:id]).user != @current_user
      flash[:error] = "You cannot delete another user's photos."
      redirect_to(:action => :index, :id => current_user_id)
    elsif params[:id] and Photo.exists?(params[:id])
      photo = Photo.find(params[:id])
      flash[:success] = "Successfully deleted #{photo.file_name}"
      #Removes from directory
      File.delete(Rails.root.join('app', 'assets', 'images', photo.file_name)) if File.exist?(Rails.root.join('app', 'assets', 'images', photo.file_name))
      #Deletes photo from database
      photo.destroy
      redirect_to(:action => :index, :id => current_user_id)
    else
      flash[:error] = "Photo not found!"
      redirect_to(:action => :index, :id => current_user_id)
    end
  end

end
