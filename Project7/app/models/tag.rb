class Tag < ActiveRecord::Base
	belongs_to :user
	belongs_to :photo

	  # Checks that all fields were entered
	  validates_presence_of :photo_id, :user_id, :x_pos, :y_pos, :width, :height, presence: true,
		  :message => "Invalid tag data."	
end