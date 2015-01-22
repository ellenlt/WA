=begin
The filter method takes an array of numbers and an optional hash.
It filters the array according to the options specified in the
hash (min, max, odd, even, scale).
=end
def filter(arr, opt={})
	#Iterates over each number in the array
	arr.each do |num|
		#Apply options contained in the hash, if defined
		unless(!opt.empty? &&
				((opt.has_key?(:min) && num < opt[:min]) ||
				 (opt.has_key?(:max) && num > opt[:max]) ||
				 (opt.has_key?(:odd) && num.even?) 		 ||
				 (opt.has_key?(:even) && num.odd?)			)) then
				#Scale numbers if necessary
				yield opt.has_key?(:scale) ? num*opt[:scale] : num
		end
	end
end

#Test code begins
puts "This is the test code for the filter method."
puts

#Test code 1
nums = [6, -5, 319, 400, 18, 94, 11]
opt = {min:10, max:350, odd:1, scale:2}
puts "Array: #{nums.to_s}
Filtering options: #{opt.to_s}
Filtered Array: "
filter(nums, opt) {|n| puts n}
puts

#Test code 2 - Same array but different hash / filtering options
opt = {max:20, even:10}
puts "Array: #{nums.to_s}
Filtering options: #{opt.to_s}
Filtered Array: "
filter(nums, opt) {|n| puts n}
puts

#Test code 3 - No hash argument
puts "Array: #{nums.to_s}
Filtering options: none
Filtered Array: "
filter(nums) {|n| puts n}
puts
