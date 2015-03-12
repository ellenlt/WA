class Tag < ActiveRecord::Base
	belongs_to :user
	belongs_to :photo

	# Returns full name of the user associated with the tag
	def user_name
  		User.find(self.user_id).full_name
 	end

	  # Checks that all fields were entered
	  validates_presence_of :photo_id, :user_id, :x_pos, :y_pos, :width, :height, presence: true,
		  :message => "Invalid tag data."	
end