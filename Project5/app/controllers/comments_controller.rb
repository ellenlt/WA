class CommentsController < ApplicationController
  
  def new
  	@photo = Photo.find_by_id(params[:id])
  end

  def create
  	current_photo = Photo.find_by_id(params[:id])
  	@@new_comment = Comment.new
  	@@new_comment.photo_id = current_photo.id
  	@@new_comment.user_id = session[:current_user_id]
  	@@new_comment.date_time = Time.now.utc
  	@@new_comment.comment = params[:comment]
  	@@new_comment.save
  	current_photo.comments << @@new_comment
  	redirect_to(:controller => :photos, :action => :index, :id => current_photo.user.id)
  end
end
