require 'set'

module Enumerable

=begin
This method is an iterator that yields two items at a time: 
a one-character string and an array of all input values 
starting with that character.
=end
	def each_group_by_first_char
		used_ch = Set.new
		self.each_entry do |entry|
			next if entry.empty?
			ch = entry[0]
			if !used_ch.include?(ch) then
				#Keeps track of characters that have already been used
				used_ch << ch 
				#Selects all words in array beginning with ch
				words = self.select {|word| word.start_with?(ch)}
				yield(ch, words)
			end
		end
	end
end

#Test code 1
arr = ["abcd", "axyz", "able", "xyzab", "qrst"]
puts "Array: #{arr}"
arr.each_group_by_first_char do |ch, words|
	printf("%s: %s\n", ch, words.join(" "))
end
puts


#Test code 2
arr = ["abcd", "", "  oops", " space in front"]
puts "Array: #{arr}"
arr.each_group_by_first_char do |ch, words|
	printf("%s: %s\n", ch, words.join(" "))
end
puts