class TagsController < ApplicationController

  def new
    if(!logged_in?)
      flash[:error] = "Must be logged in to tag."
      redirect_to(:controller => :users, :action => :login)
    elsif(params[:id] and Photo.exists?(params[:id]))
    	@tag = Tag.new
  		@users = User.all()
       	@photo = Photo.find(params[:id])
    	@tag = Tag.new()
    else
      flash[:error] = "Photo not found!"
      redirect_to(:controller => :users, :action => :index)
    end
  end

  def create
	tag = Tag.new(tag_params(params[:tag]))
  	if(!logged_in?)
      flash[:error] = "Must be logged in to tag."
      redirect_to(:controller => :users, :action => :login)
    elsif(!params[:id] or !Photo.exists?(params[:id]))
		flash[:error] = "Photo not found!"
      	redirect_to(:controller => :users, :action => :index)
    else
  		if tag.save()
  			flash[:success] = "You tagged #{tag.user.full_name}"
	  		redirect_to(:controller => :photos, :action => :index, :id => tag.photo.user.id)
		else
        	tag.errors.full_messages.each do |mess|
  				flash[:error] = mess
  			end
			redirect_to(:action => :new, :id => tag.photo.id)
		end
	end
  end

  private
  def tag_params(params)
  	return params.permit(:id, :photo_id, :user_id, :x_pos, :y_pos, :width, :height)
  end

end