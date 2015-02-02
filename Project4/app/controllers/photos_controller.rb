class PhotosController < ApplicationController
  def index
  	# photos/index/id displays all of the photos belonging to a particular user.
  	# For each photo you must display the photo itself, the creation time for the photo, 
  	# and all of the comments for that photo. For each comment you must display 
  	# time when the comment was created, the name of the user who created the comment, 
  	# and the text of the comment. The creator for each comment should be a link 
  	# that can be clicked to switch to the photos page for that user.
  	@user = User.find_by_id(params[:id])
  	@photos = Photo.all()
  	@comments = Comment.all()
  end
end
