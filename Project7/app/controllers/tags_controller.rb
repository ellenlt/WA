class TagsController < ApplicationController

  def new
    if(!logged_in?)
      flash[:error] = "Must be logged in to tag."
      redirect_to(:controller => :users, :action => :login)
    elsif(params[:id] and Photo.exists?(params[:id]))
       	@photo = Photo.find(params[:id])
    	@tag = Tag.new()
    else
      flash[:error] = "Photo not found!"
      redirect_to(:controller => :users, :action => :index)
    end
  end
=begin
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
  def tag_params(params)
  	return params.permit(:id, :date_time, :photo_id, :user_id)
  end
=end
end
