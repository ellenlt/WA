class Adder
	#Constructor that takes a single integer argument
	def initialize(num)
		@num = num
	end

=begin
	If method has a plusnum format where num is a positive number,
	create a new method that adds num to the argument passed to
	the object constructor
=end
	def method_missing(method, *args)
		#Determines if the method name is the correct format
		if method.to_s =~ /^plus(\d+)$/
			self.class.class_eval do
				define_method(method) {@num + $1.to_i}	
			end
		else
			super
		end
	end
end