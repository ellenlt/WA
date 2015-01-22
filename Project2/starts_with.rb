=begin
This method takes in an array of strings, a string, and a code block.
It iterates over each of the strings in the array, 
invoking the block for each element whose first characters match
the second arg exactly. THe matching string is passed to the block
as an arg.
=end
def each_starts_with(arr, pattern)
	#Checks each string in array
	arr.each do |string|
		#If string begins with pattern, yield to code block 
		#and record the match
		if(string.class == String && string.start_with?(pattern)) then
			yield string
		end
	end
end

#Test code begins
puts "This is the test code for the starts_with method."
puts

#Test code 1
testarr = ["abacus", "abdominal", "lab", "rehab", 3, "a", "b"]
testpattern = "ab"
puts "For the array: #{testarr.to_s}
the strings starting with \"#{testpattern}\" are: "
each_starts_with(testarr, testpattern) { |s| puts s }
puts

#Test code 2
testarr = ["beats", "eatery", "ate", "tea", "eating"]
testpattern = "eat"
puts "For the array: #{testarr.to_s}
the strings starting with \"#{testpattern}\" are: "
each_starts_with(testarr, testpattern) { |s| puts s }
puts

#Test code 3
testarr = ["beats", "", "eatery", "tea", "eating"]
testpattern = ""
puts "For the array: #{testarr.to_s}
the strings starting with \"#{testpattern}\" are: "
each_starts_with(testarr, testpattern) { |s| puts s }