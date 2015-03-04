class Photo < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	has_many :tags
	def num_comments
		self.comments.count
	end
end
