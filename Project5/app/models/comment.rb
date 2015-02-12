class Comment < ActiveRecord::Base
	belongs_to :photo
	belongs_to :user
=begin
	def validate_comment
		if (comment.lstrip.empty?) then
			errors.add(:comment, "This field must not be empty")
		end
	end

	validate :validate_comment
=end
	validates_presence_of :comment,
		:message => "This field must not be empty"
end
