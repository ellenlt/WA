class Photo < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	has_many :tags
	def num_comments
		self.comments.count
	end
	def num_tags
		self.tags.count
	end

	# Returns an array of all photos with a comment whose text contains the substring,
	# or with a tagged user whose name contains the substring. No duplicate photos in array.
	def self.filter(substring)
		substring == "" if substring.nil?
		result = Array.new()
		return result if (substring == "")  # If empty substring, returns empty array
		Photo.all().each do |photo|
			photo.tags.each do |tag|
				result << photo if tag.user_name.downcase.include? substring.downcase and !result.include? photo
			end
			photo.comments.each do |comment|
				result << photo if comment.comment.downcase.include? substring.downcase and !result.include? photo
			end
		end
		return result
	end
end