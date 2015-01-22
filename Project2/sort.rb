=begin
Takes an array of strings, sorts the strings by the first sequence
of digits in each string, and returns an array containing the 
sorted strings. Strings with no digits appear first
Must use sort function implemented by Enumerable module
Must provide block that ensures correct sorting order
=end

def funny_sort (arr)
	arr.sort do |x, y|
		#Finds first number in string and converts to Fixnum
		if x =~ /\d/
			xval = /\d+/.match(x)[0].to_i
		else xval = -1	#Assigns -1 if no numbers found
		end
		if y =~ /\d/
			yval = /\d+/.match(y)[0].to_i
		else yval = -1
		end
		xval <=> yval	#Compares the two numbers
	end
end

#Method that prints out the results of a given funny_sorted array
def test_funny_sort(arr)
	puts "The initial array is: #{arr.to_s}"
	sortedtest = funny_sort(arr)
	puts "The funny sorted array is: #{sortedtest.to_s}\n\n"
end

#Test code
test_funny_sort(['alpha100', 'beta50', 'cedro0', ''])
test_funny_sort(['app30.6le', 'cat', 'deer-100x50'])
test_funny_sort(['-200', '20', '2thousandand50'])
test_funny_sort(['05annoy988', '0disrupt780', '0538'])
