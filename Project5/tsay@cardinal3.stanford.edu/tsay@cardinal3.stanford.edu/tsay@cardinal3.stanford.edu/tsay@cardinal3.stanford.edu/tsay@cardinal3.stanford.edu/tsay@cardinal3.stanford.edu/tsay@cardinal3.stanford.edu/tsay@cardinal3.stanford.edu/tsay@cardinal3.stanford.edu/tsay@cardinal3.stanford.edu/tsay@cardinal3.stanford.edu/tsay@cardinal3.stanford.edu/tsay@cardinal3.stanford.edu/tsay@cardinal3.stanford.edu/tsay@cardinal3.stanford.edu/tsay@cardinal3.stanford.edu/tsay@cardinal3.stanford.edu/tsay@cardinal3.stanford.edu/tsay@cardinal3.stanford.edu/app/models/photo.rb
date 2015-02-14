class Photo < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	def num_comments
		self.comments.count
	end
end
