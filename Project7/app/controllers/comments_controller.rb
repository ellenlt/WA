class CommentsController < ApplicationController

#comments/new/id displays form where user adds comment for a photo whose primary key is id  
  def new
    if(!logged_in?)
      flash[:error] = "Must be logged in to comment."
      redirect_to(:controller => :users, :action => :login)
    elsif(params[:id] and Photo.exists?(params[:id]))
       @photo = Photo.find(params[:id])
    	 @comment = Comment.new()
    else
      flash[:error] = "Photo not found!"
      redirect_to(:controller => :users, :action => :index)
    end
  end

  def create
  	@comment = Comment.new(comment_params(params[:comment]))
  	if @comment.save
	  	redirect_to(:controller => :photos, :action => :index, :id => @comment.photo.user_id)
	  else
      @comment.errors.full_messages.each do |mess|
        flash[:error] = mess
      end
		  redirect_to(:action => :new, :id => @comment.photo.id)
	  end
  end

  private
  def comment_params(params)
  	return params.permit(:comment, :id, :date_time, :photo_id, :user_id)
  end

end


