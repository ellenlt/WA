class CommentsController < ApplicationController

#comments/new/id displays form where user adds comment for a photo whose primary key is id  
  def new
  	@photo = Photo.find(params[:id])
  	@comment = Comment.new()
  end

  def create
  	@comment = Comment.new(comment_params(params[:comment]))
  	if @comment.save
	  	redirect_to(:controller => :photos, :action => :index, :id => @comment.photo.user_id)
	else
		  flash[:error] = @comment.errors.full_messages.first
		  redirect_to(:action => :new, :id => @comment.photo.id)
	end
  end

  private
  def comment_params(params)
  	return params.permit(:comment, :id, :date_time, :photo_id, :user_id)
  end

end
