class User < ActiveRecord::Base
	has_many :photos
	has_many :comments
	def full_name
  		self.first_name + " " + self.last_name
  	end
end
